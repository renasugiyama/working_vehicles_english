class ResultsController < ApplicationController
  skip_before_action :require_login, only: [:check]

  def index
    @player = current_user.players.find_by(id: session[:current_player_id])
    @results = @player.results  # プレイヤーに関連する全ての結果を取得
  end

  def show
    @player = current_user.players.find_by(id: session[:current_player_id])
    @result = @player.results.find(params[:id])  # URLから特定の結果を取得
  end

  def correct
    @player = current_user.players.find_by(id: session[:current_player_id])

    if @player
      @player.increment!(:correct_count)
    end
  end

  def incorrect
    @player = current_user.players.find_by(id: session[:current_player_id]) 
    
    if @player
      @player.increment!(:incorrect_count)
    end
  end
  
  def check
    @choice = Choice.find(params[:id])
    session[:current_question_id] = @choice.question.id  # 質問のIDをセッションに保存
    correct = @choice.is_correct

    # プレイヤーと質問を取得（セッションやリクエストからプレイヤーIDを取得する）
    @player = current_user.players.find_by(id: session[:current_player_id])

    if @player.nil?
      flash[:error] = "プレイヤーが見つかりませんでした"
      redirect_to root_path and return
    end

    begin
      # Resultを保存
      @result = @player.results.create!(
        question: @choice.question,
        choice: @choice,
        correct: correct
      )
    rescue => e
      flash[:error] = "結果の保存に失敗しました: #{e.message}"
      redirect_to root_path and return
    end

    if @choice.is_correct
      session[:current_question_id] = nil  # セッションをクリア
      redirect_to correct_results_path
    else
      redirect_to incorrect_results_path
    end
  end
end

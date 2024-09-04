class ResultsController < ApplicationController
  skip_before_action :require_login, only: [:check, :guest_check]

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
    # ログインしていない場合はゲスト用の処理へ
    unless logged_in?
      return guest_check
    end

    # プレイヤーが設定されているか確認
    @player = current_user.players.find_by(id: session[:current_player_id])

    if @player.nil?
      if current_user.players.exists?
        flash[:alert] = "プレイヤーを設定してください。"
        redirect_to players_switch_path and return
      else
        flash[:alert] = "プレイヤーを作成し、プレイヤーの設定を実施してください。"
        redirect_to new_player_path and return
      end
    end

    @choice = Choice.find(params[:id])
    session[:current_question_id] = @choice.question.id  # 質問のIDをセッションに保存
    correct = @choice.is_correct

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

  def guest_check
    @choice = Choice.find(params[:id])
    session[:current_question_id] = @choice.question.id  # 質問のIDをセッションに保存

    if @choice.is_correct
      session[:current_question_id] = nil  # 正解の場合にセッションをクリア
      render 'correct'
    else
      render 'incorrect'
    end
  end
end

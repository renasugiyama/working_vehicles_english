class QuestionsController < ApplicationController
  skip_before_action :require_login, only: [:random]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:random]
  before_action :ensure_player_selected, only: [:random]
  before_action :check_terms_agreement, only: [:random], unless: -> { logged_in? }

  def show; end

  def random
    if session[:current_question_id]
      @question = Question.find_by(id: session[:current_question_id])
    else
      displayed_question_ids = session[:displayed_question_ids] || []
      available_questions = Question.where.not(id: displayed_question_ids)
  
      if available_questions.exists?
        @question = available_questions.order("RAND()").first
      else
        # すべての質問を表示し終えたら、セッションをリセットして再度表示を始める
        session[:displayed_question_ids] = []
        @question = Question.order("RAND()").first
      end
    end
  
    # @questionがnilでないかチェック
    if @question
      session[:displayed_question_ids] ||= []
      session[:displayed_question_ids] << @question.id
      @choices = @question.choices
    else
      # @questionがnilの場合の処理を追加
      redirect_to root_path, alert: "質問が見つかりませんでした。"
    end
  end

  def new
    @question = Question.new
    3.times { @question.choices.build }
  end

  def create
    @question = Question.new(question_params)
    set_correct_choice
    if @question.save
      redirect_to questions_path, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def edit
    (3 - @question.choices.size).times { @question.choices.build }
  end

  def update
    set_correct_choice
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question was successfully destroyed.'
  end

  def index
    @questions = Question.page(params[:page]).per(10) # 1ページあたり10件表示
  end

  # プレイヤーが設定されているか確認するメソッド
  def ensure_player_selected
    if current_user && session[:current_player_id].nil?
      flash[:alert] = "プレイヤーを設定してください。"
      redirect_to switch_players_path
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content, :question_image, choices_attributes: [:id, :content, :is_correct, :_destroy])
  end

  def set_correct_choice
    correct_choice_id = params[:question][:correct_choice]
    if correct_choice_id.to_i.to_s == correct_choice_id # 新しい選択肢のIDは数値であるため
      correct_choice_index = correct_choice_id.to_i
      @question.choices.each_with_index do |choice, index|
        choice.is_correct = (index == correct_choice_index)
      end
    else
      @question.choices.each do |choice|
        choice.is_correct = (choice.id.to_s == correct_choice_id)
      end
    end
  end

  def require_admin
    unless current_user&.admin?
      flash[:alert] = "管理者のみがアクセスできます。"
      redirect_to root_path
    end
  end

  # 利用規約に同意しているか確認する
  def check_terms_agreement
    unless session[:agreed_to_terms]
      redirect_to terms_path # 利用規約ページのパスに変更
    end
  end
end

class ResultsController < ApplicationController
  skip_before_action :require_login, only: [:check]

  def check
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

class ResultsController < ApplicationController
  def create
    choice = Choice.find(params[:id])
    if choice.is_correct
      redirect_to correct_result_path
    else
      redirect_to incorrect_result_path
    end
  end

  def correct
  end

  def incorrect
  end

  def streak
  end
end

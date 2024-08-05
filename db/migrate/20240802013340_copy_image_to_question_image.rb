class CopyImageToQuestionImage < ActiveRecord::Migration[7.1]
  def up
    Question.reset_column_information
    Question.find_each do |question|
      question.update_column(:question_image, question.image) if question.image.present?
    end
  end

  def down
    Question.reset_column_information
    Question.find_each do |question|
      question.update_column(:image, question.question_image) if question.question_image.present?
    end
  end
end

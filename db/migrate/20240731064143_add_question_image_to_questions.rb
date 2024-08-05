class AddQuestionImageToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :question_image, :string
  end
end

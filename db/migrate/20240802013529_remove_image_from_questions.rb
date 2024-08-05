class RemoveImageFromQuestions < ActiveRecord::Migration[7.1]
  def change
    remove_column :questions, :image, :string
  end
end

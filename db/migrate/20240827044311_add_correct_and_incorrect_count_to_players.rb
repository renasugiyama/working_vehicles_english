class AddCorrectAndIncorrectCountToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :correct_count, :integer
    add_column :players, :incorrect_count, :integer
  end
end

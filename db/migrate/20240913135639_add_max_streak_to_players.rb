class AddMaxStreakToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :max_streak, :integer, default: 0
  end
end

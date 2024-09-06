class AddStatsToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :correct_streak, :integer
    add_column :players, :total_correct_count, :integer
    add_column :players, :total_answers, :integer
    add_column :players, :incorrect_streak, :integer
    add_column :players, :daily_play_count, :integer
    add_column :players, :last_played_at, :datetime
  end
end

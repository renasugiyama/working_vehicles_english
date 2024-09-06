class SetDefaultValuesForPlayerStats < ActiveRecord::Migration[7.1]
  def change
    change_column_default :players, :correct_streak, from: nil, to: 0
    change_column_default :players, :total_correct_count, from: nil, to: 0
    change_column_default :players, :total_answers, from: nil, to: 0
    change_column_default :players, :incorrect_streak, from: nil, to: 0
    change_column_default :players, :daily_play_count, from: nil, to: 0
  end
end

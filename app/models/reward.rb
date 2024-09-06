class Reward < ApplicationRecord
  has_many :player_rewards
  has_many :players, through: :player_rewards

  # リワード達成条件のチェックメソッド（カスタムロジックを追加）
  def achieved?(player)
    case condition_type
    when 'streak'
      player.correct_streak >= condition_value
    when 'total_correct'
      player.total_correct_count >= condition_value
    when 'total_answers'
      player.total_answers >= condition_value
    when 'consecutive_incorrect'
      player.incorrect_streak >= condition_value
    # 他の条件も追加可能
    else
      false
    end
  end
end

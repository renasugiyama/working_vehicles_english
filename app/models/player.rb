class Player < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :player_rewards
  has_many :rewards, through: :player_rewards

  mount_uploader :player_image, PlayerImageUploader

  validates :nickname, presence: true, length: { maximum: 10 }
  validates :gender, inclusion: { in: %w[male female] }

  # リワードが達成されているかどうかを確認するメソッド
  def reward_achieved?(reward)
    self.rewards.include?(reward)
  end
end

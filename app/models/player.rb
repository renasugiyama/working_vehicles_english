class Player < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :player_rewards
  has_many :rewards, through: :player_rewards
  has_many :video_playbacks
  before_save :set_default_can_play_video #OK
  has_one :player_video_setting, dependent: :destroy # プレイヤーに対する動画再生設定の関連付け OK

  # プレイヤー作成時に関連する player_video_setting を初期化する
  after_create :initialize_player_video_setting #OK

  mount_uploader :player_image, PlayerImageUploader

  scope :eligible_for_video, -> { where(correct_streak: 3, can_play_video: false) } #OK

  validates :nickname, presence: true, length: { maximum: 10 }
  validates :gender, inclusion: { in: %w[male female] }

  # リワードが達成されているかどうかを確認するメソッド
  def reward_achieved?(reward)
    self.rewards.include?(reward)
  end

  private

  def set_default_can_play_video
    self.can_play_video = false if can_play_video.nil?
  end

  def initialize_player_video_setting #OK
    # play_video_after_correct_count を 0 に設定して player_video_setting を作成
    create_player_video_setting(play_video_after_correct_count: 0)
  end
end

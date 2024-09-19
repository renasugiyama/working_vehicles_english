class PlayerVideoSetting < ApplicationRecord
  belongs_to :player, optional: true

  # GlobalとPlayerの設定バリデーション
  validate :validate_global_and_player_settings

  validates :play_video_after_correct_count, presence: { message: '再生条件を選択してください。' }

  # マイページで設定内容を確認するメソッド
  def self.for_player(player)
    find_by(player: player) || new(player: player, play_video_after_correct_count: 0)
  end
  
  # randomで表示するときに再生設定を確認するメソッド
  def self.get_setting_for(player)
    find_by(player: player) || find_by(player_id: nil, is_global: true)
  end

  # バリデーションとスコープの追加
  scope :global, -> { where(is_global: true).order(created_at: :desc).first }

  private

  # 一括設定とプレイヤーごとの設定を区別し、同時適用を防ぐバリデーション
  def validate_global_and_player_settings
    if is_global && player_id.present?
      errors.add(:base, "プレイヤーごとの設定と全プレイヤー共通の設定を同時に適用することはできません。<br>プレイヤー毎の設定の場合は、全プレイヤー共通の設定のチェックを外してください。")
    elsif player_id.nil? && !is_global
      errors.add(:base, "プレイヤーを選択するか、全プレイヤー共通の設定にチェックを入れてください。")
    end
  end
end

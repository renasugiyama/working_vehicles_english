class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.reset_password_mailer = UserMailer # パスワードリセット時のMailerを設定
  end

  mount_uploader :user_image, UserImageUploader

  has_many :players, dependent: :destroy
  accepts_nested_attributes_for :players, allow_destroy: true

  enum role: { user: 0, admin: 1 }

  before_update :prevent_role_change, if: :admin?
  before_create :ensure_not_admin

  validates :password, length: { minimum: 7 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def user_image_url
    if user_image.is_a?(CarrierWave::Uploader::Base)
      user_image.url.presence
    elsif user_image.is_a?(String)
      user_image.presence
    else
      nil
    end
  end

  private

  def prevent_role_change
    if self.role_changed? && self.role_was == "admin"
      errors.add(:role, "管理者権限を変更することはできません")
      throw(:abort)
    end
  end

  def ensure_not_admin
    self.role = :user if self.role == "admin"
  end

  def user_params
    params.require(:user).permit(:name, :user_image, players_attributes: [:id, :nickname, :birth_date, :gender, :player_image, :_destroy])
  end
end

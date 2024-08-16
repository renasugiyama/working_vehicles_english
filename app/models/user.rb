class User < ApplicationRecord
  authenticates_with_sorcery!

  enum role: { user: 0, admin: 1 }

  before_update :prevent_role_change, if: :admin?
  before_create :ensure_not_admin

  validates :password, length: { minimum: 5 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true

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
end

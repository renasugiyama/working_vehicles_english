class Player < ApplicationRecord
  belongs_to :user
  has_many :results, dependent: :destroy

  mount_uploader :player_image, PlayerImageUploader

  validates :nickname, presence: true, length: { maximum: 10 }
  validates :gender, inclusion: { in: %w[male female] }
end

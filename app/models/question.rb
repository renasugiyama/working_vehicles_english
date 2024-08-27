class Question < ApplicationRecord
  has_many :choices, dependent: :destroy
  has_many :results
  accepts_nested_attributes_for :choices, allow_destroy: true, reject_if: :all_blank

  validates :content, presence: true
  validates :question_image, presence: true

  mount_uploader :question_image, QuestionImageUploader
end

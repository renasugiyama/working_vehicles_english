class Choice < ApplicationRecord
  belongs_to :question
  has_many :results
  
  validates :content, presence: true
  validates :is_correct, inclusion: { in: [true, false] }
end

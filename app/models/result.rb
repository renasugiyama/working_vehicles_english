class Result < ApplicationRecord
  belongs_to :player
  belongs_to :question
  belongs_to :choice

  validates :player_id, presence: true
  validates :question_id, presence: true
  validates :choice_id, presence: true
  validates :correct, inclusion: { in: [true, false] }
end

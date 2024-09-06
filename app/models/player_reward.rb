class PlayerReward < ApplicationRecord
  belongs_to :player
  belongs_to :reward
end

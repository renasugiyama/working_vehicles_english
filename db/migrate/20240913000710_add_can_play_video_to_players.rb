class AddCanPlayVideoToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_column :players, :can_play_video, :boolean, default: false
  end
end

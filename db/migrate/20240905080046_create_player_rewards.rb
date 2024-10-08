class CreatePlayerRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :player_rewards do |t|
      t.references :player, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true

      t.timestamps
    end
  end
end

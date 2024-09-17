class CreateVideoPlaybacks < ActiveRecord::Migration[7.1]
  def change
    create_table :video_playbacks do |t|
      t.references :player, null: false, foreign_key: true
      t.datetime :played_at

      t.timestamps
    end
  end
end

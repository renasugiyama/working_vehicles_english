class RemoveUniqueIndexFromPlayerVideoSettings < ActiveRecord::Migration[7.1]
  def change
    # インデックス名が実際にデータベースで設定されている名前と一致するようにしてください
    remove_index :player_video_settings, name: 'index_player_video_settings_on_is_global'
  end
end

class CreatePlayerVideoSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :player_video_settings do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :play_video_after_correct_count, default: 0
      t.boolean :is_global, default: false # 全プレイヤー共通の設定かどうかを示すフラグ

      t.timestamps
    end
    # is_global が true の場合にのみユニークになるインデックスを追加
    # is_global: true のレコードがデータベース内に一つしか存在しないことを保証します。
    add_index :player_video_settings, :is_global, unique: true, where: "is_global = true"
  end
end

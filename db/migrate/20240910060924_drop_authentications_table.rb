class DropAuthenticationsTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :authentications
  end

  def down
    create_table :authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid
      t.timestamps

      t.index [:provider, :uid], unique: true
    end
  end
end

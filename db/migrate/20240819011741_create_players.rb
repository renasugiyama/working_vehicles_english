class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :nickname
      t.date :birth_date
      t.string :gender
      t.string :player_image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.string :title
      t.string :description
      t.string :icon
      t.string :condition_type
      t.integer :condition_value

      t.timestamps
    end
  end
end

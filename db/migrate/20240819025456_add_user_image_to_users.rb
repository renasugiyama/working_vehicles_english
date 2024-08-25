class AddUserImageToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_image, :string
  end
end

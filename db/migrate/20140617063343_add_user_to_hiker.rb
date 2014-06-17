class AddUserToHiker < ActiveRecord::Migration
  def change
    add_column :hikers, :user_id, :integer
    add_index  :hikers, :user_id
    add_column :hikers, :email, :string
    add_column :hikers, :profile_image_url, :string
    add_column :hikers, :profile_chip_url, :string
  end
end

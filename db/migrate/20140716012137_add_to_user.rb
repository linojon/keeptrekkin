class AddToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_url, :string
    add_column :users, :image_url, :string
    remove_column :users, :profile_image_url
    remove_column :users, :profile_chip_url
  end
end

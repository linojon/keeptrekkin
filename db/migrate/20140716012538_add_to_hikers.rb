class AddToHikers < ActiveRecord::Migration
  def change
    add_column :hikers, :profile_image, :string
    add_column :hikers, :location, :string
    add_column :hikers, :disable_notifications, :boolean
  end
end

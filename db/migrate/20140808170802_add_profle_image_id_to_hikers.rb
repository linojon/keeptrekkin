class AddProfleImageIdToHikers < ActiveRecord::Migration
  def change
    add_column    :hikers, :profile_image_id, :integer
    remove_column :hikers, :profile_image_url
    remove_column :hikers, :profile_chip_url
  end
end

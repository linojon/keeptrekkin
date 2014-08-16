class RemoveProfileImageFromHikers < ActiveRecord::Migration
  def change
    remove_column :hikers, :profile_image
  end
end

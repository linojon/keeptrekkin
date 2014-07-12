class AddFieldsToMountains < ActiveRecord::Migration
  def change
    add_column :mountains, :full_name, :string
    add_column :mountains, :location, :string
    add_column :mountains, :state, :string
    add_column :mountains, :lat, :float
    add_column :mountains, :lng, :float
    add_column :mountains, :description, :text
    add_column :mountains, :hikes, :text
  end
end

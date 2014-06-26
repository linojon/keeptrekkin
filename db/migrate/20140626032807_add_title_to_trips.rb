class AddTitleToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :title, :string
    rename_column :trips, :notes, :journal
    change_column :trips, :distance, :string
    change_column :trips, :duration, :string
  end
end

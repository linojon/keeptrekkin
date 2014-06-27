class RemoveHabtm < ActiveRecord::Migration
  def change
    rename_table :mountains_trips, :mountain_trips
    rename_table :hikers_trips, :hiker_trips
  end
end

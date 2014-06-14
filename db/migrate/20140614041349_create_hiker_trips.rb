class CreateHikerTrips < ActiveRecord::Migration
  def change
    create_table :hikers_trips, id: false do |t|
      t.references :hiker, null: false
      t.references :trip, null: false
    end

    add_index :hikers_trips, [:hiker_id, :trip_id], :unique => true
  end
end

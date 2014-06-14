class CreateMountainTrips < ActiveRecord::Migration
  def change
    create_table :mountains_trips, id: false do |t|
      t.references :mountain, null: false
      t.references :trip, null: false
    end

    add_index :mountains_trips, [:mountain_id, :trip_id], :unique => true
  end
end

class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.date :date
      t.float :distance
      t.integer :duration
      t.text :notes

      t.timestamps
    end
  end
end

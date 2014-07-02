class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.references :trip
      t.references :hiker
      t.string :image
      t.string :caption
    end
    add_index  :pictures, :trip_id
    add_index  :pictures, :hiker_id
  end
end

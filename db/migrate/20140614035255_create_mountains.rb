class CreateMountains < ActiveRecord::Migration
  def change
    create_table :mountains do |t|
      t.string :name
      t.integer :elevation

      t.timestamps
    end
  end
end

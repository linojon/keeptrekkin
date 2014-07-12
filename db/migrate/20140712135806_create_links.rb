class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :site_name
      t.string :url
      t.string :rating
      t.references :mountain, index: true

      t.timestamps
    end
  end
end

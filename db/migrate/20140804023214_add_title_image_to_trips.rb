class AddTitleImageToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :title_image_id, :integer
  end
end

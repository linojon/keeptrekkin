class ChangeUserBelongsToHiker < ActiveRecord::Migration
  def change
    add_column :users, :hiker_id, :integer
    remove_column :hikers, :user_id
  end
end

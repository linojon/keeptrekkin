class AddHikerToAttachinaryFiles < ActiveRecord::Migration
  def change
    add_reference :attachinary_files, :hiker, index: true
  end
end

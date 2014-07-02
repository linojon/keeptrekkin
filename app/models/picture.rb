class Picture < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user

  mount_uploader :image, ImageUploader

end

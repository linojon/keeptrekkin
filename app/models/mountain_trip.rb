class MountainTrip < ActiveRecord::Base
  belongs_to :mountain
  belongs_to :trip
end

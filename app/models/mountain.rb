class Mountain < ActiveRecord::Base
  has_many :mountain_trips
  has_many :trips, through: :mountain_trips
  has_many :hikers, through: :trips
  
  validates :name, presence: true, uniqueness: true
end

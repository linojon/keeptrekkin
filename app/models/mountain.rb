class Mountain < ActiveRecord::Base
  has_many :mountain_trips, dependent: :destroy
  has_many :trips, through: :mountain_trips
  has_many :hikers, through: :trips
  has_many :links, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true

  default_scope { order('elevation DESC') }

  def elevation_meters
    (elevation * 0.3048 + 0.5).to_i
  end
end

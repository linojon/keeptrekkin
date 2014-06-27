class Trip < ActiveRecord::Base
  has_many :hiker_trips
  has_many :mountain_trips
  
  has_many :hikers, through: :hiker_trips
  has_many :mountains, through: :mountain_trips

  before_validation :set_defaults

  def set_defaults
    self.date ||= Date.today
  end

end

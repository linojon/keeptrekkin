class Trip < ActiveRecord::Base
  has_many :hiker_trips
  has_many :mountain_trips
  
  has_many :hikers, through: :hiker_trips
  has_many :mountains, through: :mountain_trips

  has_attachment :profile_image

  before_validation :set_defaults

  def set_defaults
    self.date ||= Date.today
  end

  # dont let disabled select widget wipe out these
  def update_mountains( ids )
    ids = ids.to_a
    ids -= ['']
    self.mountain_ids = ids unless ids.empty?
  end
  def update_hikers( ids )
    ids = ids.to_a
    ids -= ['']
    self.hiker_ids = ids unless ids.empty?
  end 

end

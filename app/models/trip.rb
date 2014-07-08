class Trip < ActiveRecord::Base
  has_many :hiker_trips
  has_many :mountain_trips
  
  has_many :hikers, through: :hiker_trips
  has_many :mountains, through: :mountain_trips

  has_attachment :title_image
  has_attachments :photos

  before_validation :set_defaults

  default_scope { order('date DESC') }

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
    current_ids = self.hiker_ids.map(&:to_s)
    ids = ids.to_a
    ids -= ['']
    self.hiker_ids = ids unless ids.empty?
    # return new ones
    ids - current_ids 
  end 

end

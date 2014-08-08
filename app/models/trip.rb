class Trip < ActiveRecord::Base
  has_many :hiker_trips, dependent: :destroy
  has_many :mountain_trips, dependent: :destroy
  
  has_many :hikers, through: :hiker_trips
  has_many :mountains, through: :mountain_trips

  has_attachments :photos

  belongs_to :title_image, class_name: 'Attachinary::File'
  attr_accessor :title_image_input
  after_save :set_title_image

  #default_scope { order('date DESC') }

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
    current_ids = self.hiker_ids.map(&:to_s)
    ids = ids.to_a
    ids -= ['']
    self.hiker_ids = ids unless ids.empty?
    # return new ones
    ids - current_ids 
  end 

  # workaround for attachinary custom hiker_id
  def associate_photos_with( hiker )
    photos.where(hiker_id: nil).each do |photo|
      photo.update_attribute :hiker_id, hiker.id
    end
  end

  # allow attachinary public_id to be input for title_image; stow and handle after attachinary save
  def title_image_input
    title_image && title_image.public_id
  end

  def title_image_input=(image)
    @title_image_input = image
  end

  def set_title_image
    if @title_image_input.is_a? Attachinary::File
      image_id = val.id
    elsif photo = photos.where(public_id: @title_image_input).first
      image_id = photo.id
    else
      image_id = nil
    end
    update_column :title_image_id, image_id
  end

end



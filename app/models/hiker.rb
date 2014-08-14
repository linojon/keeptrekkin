class Hiker < ActiveRecord::Base
  has_one :user, dependent: :destroy
  has_many :hiker_trips, dependent: :destroy
  has_many :trips, through: :hiker_trips
  has_many :mountains, through: :trips
  has_many :friends, -> { distinct }, through: :trips, source: :hikers
  def just_friends
    friends - [self]
  end
  def friends_and_self
    ([self] + friends).uniq
  end

  has_many :photos, class_name: 'Attachinary::File'

  belongs_to :profile_image, class_name: 'Attachinary::File'
  attr_accessor :profile_image_input
  after_save :set_profile_image

  validates :name, presence: true

  scope :has_no_user, -> {
    joins('LEFT OUTER JOIN users ON users.hiker_id = hikers.id').where('users.id IS null')
  }

  # scope :not_authenticated, -> { includes(:users).where("users.hiker_id IS NULL") }

  # fuzzy search (like where) but returns collection
  attr_accessor :fuzzy_score
  def self.fuzzy( name:nil, email:nil, threshold:0.7 )
    matches = []
    self.find_each do |hiker|
      score = [
        (name && hiker.name ? name.jarowinkler_similar(hiker.name) : 0.0),
        (email && hiker.email ? email.jarowinkler_similar(hiker.email) : 0.0)
      ].max
      hiker.fuzzy_score = score 
      matches << hiker if score > threshold
    end
    matches.sort! {|a,b| b.fuzzy_score <=> a.fuzzy_score } # sort by score highest first
  end

  def update_attributes_only_if_blank(attributes)
    attributes.each { |k,v| attributes.delete(k) unless read_attribute(k).blank? }
    update(attributes)
  end

  def profile_image_url
    if profile_image
      profile_image.fullpath(size: '300x200', crop: :fill)
    elsif user 
      user.profile_image_url
    end
  end

  def profile_chip_url
    if profile_image
      profile_image.fullpath(size: '30x30', crop: :fill)
    elsif user
      user.chip_image_url
    end
  end

  # allow attachinary public_id to be input for title_image; stow and handle after attachinary save
  def profile_image_input
    profile_image && profile_image.public_id
  end

  def profile_image_input=(image)
    @profile_image_input = image
  end

  def set_profile_image
    if @profile_image_input.is_a? Attachinary::File
      image_id = val.id
    elsif photo = photos.where(public_id: @profile_image_input).first
      image_id = photo.id
    else
      image_id = nil
    end
    update_column :profile_image_id, image_id
  end

  def first_name
    name.split(' ').first if name
  end

end

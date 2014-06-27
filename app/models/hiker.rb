class Hiker < ActiveRecord::Base
  has_one :user
  has_many :hiker_trips
  has_many :trips, through: :hiker_trips
  has_many :mountains, through: :trips
  has_many :friends, -> { distinct }, through: :trips, source: :hikers
  def just_friends
    friends - [self]
  end
  def friends_and_self
    ([self] + friends).uniq
  end

  validates :name, presence: true

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

  # make this a "concerns" ?
  def update_attributes_only_if_blank(attributes)
    attributes.each { |k,v| attributes.delete(k) unless read_attribute(k).blank? }
    update(attributes)
  end
end

class Hiker < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :trips
  has_many :mountains, through: :trips

  validates :name, presence: true

  def update_attributes_only_if_blank(attributes)
    attributes.each { |k,v| attributes.delete(k) unless read_attribute(k).blank? }
    update(attributes)
  end
end

class Hiker < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :trips
  has_many :mountains, through: :trips

  validates :name, presence: true
end

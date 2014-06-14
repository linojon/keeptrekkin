class Mountain < ActiveRecord::Base
  has_and_belongs_to_many :trips
  has_many :hikers, through: :trips
  
  validates :name, presence: true, uniqueness: true
end

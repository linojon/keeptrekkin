class Trip < ActiveRecord::Base
  has_and_belongs_to_many :hikers
  has_and_belongs_to_many :mountains
end

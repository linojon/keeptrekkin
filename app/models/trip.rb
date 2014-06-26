class Trip < ActiveRecord::Base
  has_and_belongs_to_many :hikers
  has_and_belongs_to_many :mountains

  before_validation :set_defaults

  def set_defaults
    self.date ||= Date.today
  end

end

class Link < ActiveRecord::Base
  belongs_to :mountain
  default_scope { order('id') }
end

class MountainsController < ApplicationController
  after_action :verify_authorized, except: [:index, :show]

  expose(:mountains)
  expose(:mountain)  

end

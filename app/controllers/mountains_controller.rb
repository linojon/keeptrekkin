class MountainsController < ApplicationController
  after_action :verify_authorized, except: [:index, :show]

  expose(:mountains) { policy_scope(Mountain) }
  expose(:mountain)  

  def show
    authorize mountain
  end

end

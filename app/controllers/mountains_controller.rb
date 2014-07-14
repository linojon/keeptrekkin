class MountainsController < ApplicationController

  def index
    @mountains = policy_scope(Mountain)
  end

  def show
    @mountain = Mountain.find params[:id]
    authorize @mountain
  end

end

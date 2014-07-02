class HikersController < ApplicationController
  after_action :verify_authorized, except: [:index, :show]

  # expose(:trip)
  # expose(:hikers)
  expose(:hiker, attributes: :hiker_params)

  def create
    # xhr request
# byebug
    authorize hiker
    if exists = Hiker.where( email: params[:hiker][:email] ).first
      # already exists with this email, just use it, ignore name
      render json: exists
    elsif hiker.save
      render json: hiker
    else
      render json: hiker, status: :unprocessable_entity
    end
  end


  def profile
    redirect_to hiker_path(current_hiker)
  end

  def profile_edit
    redirect_to edit_hiker_path(current_hiker)
  end

  private

  def hiker_params
    params.require(:hiker).permit(:email, :name)
  end

end

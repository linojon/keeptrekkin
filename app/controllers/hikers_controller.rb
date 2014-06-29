class HikersController < ApplicationController

  # expose(:trip)
  # expose(:hikers)
  expose(:hiker, attributes: :hiker_params)

  def create
    # xhr request
    if exists = Hiker.where( email: params[:hiker][:email] ).first
      # already exists with this email, just use it, ignore name
      render json: exists
    elsif hiker.save
      render json: hiker
    else
      render json: hiker, status: :unprocessable_entity
    end
  end

  private

  def hiker_params
    params.require(:hiker).permit(:email, :name)
  end

end

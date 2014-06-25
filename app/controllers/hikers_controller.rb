class HikersController < ApplicationController

  expose(:trip)
  expose(:hiker, ancestor: :trip )

  # def create
  #   if hiker = Hiker.where( email: params[:email] ).first
  #     # already exists with this email, just use it, ignore name
  #     trip.hikers << hiker
  #     # [handle uniq exception]
  #   else

  # end

end

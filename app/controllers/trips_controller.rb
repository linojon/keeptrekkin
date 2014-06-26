class TripsController < ApplicationController

  expose(:trips)
  expose(:trip, attributes: :trip_params)

  def new
    trip.hikers << current_hiker
  end

  private

  def trip_params
    params.require(:trip).permit(:title,:journal,:mountains,:date,:hikers,:distance,:duration)  
  end

end

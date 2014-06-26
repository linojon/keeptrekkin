class TripsController < ApplicationController

  expose(:trips)
  expose(:trip, attributes: :trip_params)

  def new
    byebug
    trip.hikers << current_hiker
  end

  def create
# byebug
    if trip.save
      redirect_to(trip)
    else
      render :new
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :journal, :date, :distance, :duration, mountain_ids:[], hiker_ids:[])  
  end

end

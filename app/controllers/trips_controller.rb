class TripsController < ApplicationController

  expose(:trips)
  expose(:trip, attributes: :trip_params)

  expose(:mountains) { Mountain.all }
  expose(:friends) { Hiker.all } #{ current_hiker.friends_and_self }

  before_action :save_back, only: [:new, :edit]

  def new
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

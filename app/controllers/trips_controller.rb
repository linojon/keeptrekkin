class TripsController < ApplicationController
  after_action :verify_authorized, except: [:index, :show]

  expose(:trips)
  expose!(:trip, attributes: :trip_params)

  expose(:my_trips)     { current_hiker.trips }

  expose(:mountains)    { Mountain.all }
  expose(:friends)      { current_hiker.friends_and_self }
  expose(:site_hikers)  { Hiker.all - friends}

  before_action :save_back, only: [:new, :edit]

  def new
    authorize trip
    trip.hikers << current_hiker
  end

  def edit
    authorize trip
  end

  def create
    authorize trip
    if trip.save
      flash_no_mountains
      redirect_to(trip)
    else
      render :new
    end
  end

  def update
    authorize trip
    if trip.save
      flash_no_mountains
      redirect_to(trip)
    else
      render :edit
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:title, :journal, :date, :distance, :duration, mountain_ids:[], hiker_ids:[])  
  end

  def flash_no_mountains
    flash[:alert] = "You've saved a trip with no mountains selected" if trip.mountains.empty?
  end
end

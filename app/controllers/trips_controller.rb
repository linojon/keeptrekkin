class TripsController < ApplicationController
  after_action :verify_authorized, except: [:index, :show]

  expose(:trips) { policy_scope(Trip) }
  expose!(:trip, attributes: :trip_params)


  expose(:mountains)    { policy_scope(Mountain) }
  expose(:friends)      { current_hiker ? current_hiker.friends_and_self : [] }
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
    trip.update_mountains params[:trip][:mountain_ids]
    hikers_ids = trip.update_hikers params[:trip][:hiker_ids]
    if trip.save
      send_added_hiker_emails hikers_ids
      flash_no_mountains
      redirect_to(trip)
    else
      render :new
    end
  end

  def update
# byebug
    authorize trip
    # dont let disabled select widget wipe out these
    trip.update_mountains params[:trip][:mountain_ids]
    hikers_ids = trip.update_hikers params[:trip][:hiker_ids]
    trip.update_attribute :photos, params[:trip][:photos]
    if trip.save
      send_added_hiker_emails hikers_ids
      flash_no_mountains
      redirect_to(trip)
    else
      render :edit
    end
  end

#   def image # post /trips/:id/image
# byebug
#     # send file to cloudinary
#   end

  private

  def trip_params
    params.require(:trip).permit(:title, :journal, :date, :distance, :duration, :title_image) #, :photos) #disallow mountain_ids:[], hiker_ids:[])  
  end

  def flash_no_mountains
    flash[:alert] = "You've saved a trip with no mountains selected" if trip.mountains.empty?
  end

  def send_added_hiker_emails( ids )
    hikers = Hiker.find ids
    hikers.each do |hiker|
      HikerMailer.added_email( hiker, trip).deliver
    end
  end

end

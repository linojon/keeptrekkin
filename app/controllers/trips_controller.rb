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

    trip.build_title_picture unless trip.title_picture
  end

  def edit
    authorize trip

    trip.build_title_picture unless trip.title_picture
  end

  def create
    authorize trip
    trip.update_mountains params[:trip][:mountain_ids]
    trip.update_hikers params[:trip][:hiker_ids]

    # proto carrierwave integration
    if params[:trip][:title_picture_attributes] 
      trip.title_picture.build params[:trip][:title_picture_attributes] 
      trip.title_picture.hiker = current_hiker
    end

    if trip.save
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
    trip.update_hikers params[:trip][:hiker_ids]
byebug
    # # proto carrierwave integration
    # if params[:trip][:title_picture_attributes] 
    #   if trip.title_picture
    #     trip.title_picture.update_attributes params[:trip][:title_picture_attributes] 
    #   else
    #     # trip.build_title_picture params[:trip][:title_picture_attributes] 

    #     trip.title_picture = Picture.new params[:trip][:title_picture_attributes] 
    #   end
    #   trip.title_picture.hiker = current_hiker
    # end

    if trip.save
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
    params.require(:trip).permit :title, :journal, :date, :distance, :duration, title_picture_attributes: [ :image_cache, :image ]
    #, :profile_image) #, :photos) #disallow mountain_ids:[], hiker_ids:[])  
  end

  def flash_no_mountains
    flash[:alert] = "You've saved a trip with no mountains selected" if trip.mountains.empty?
  end
end

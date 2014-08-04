class TripsController < ApplicationController
  # after_action :verify_authorized, except: [:index, :show]

  # expose!(:trip, attributes: :trip_params)



  before_action :save_back, only: [:new, :edit]

  def index
    @trips = policy_scope(Trip)
  end

  def show
    find_and_authorize_trip
  end

  def new
    @trip = Trip.new
    authorize @trip
    @trip.hikers << current_hiker
    find_and_authorize_edit_vars
  end

  def edit
    find_and_authorize_trip
    find_and_authorize_edit_vars
  end

  def create
    render :new unless create_or_update_trip
  end

  def update
    render :edit unless create_or_update_trip
  end

#   def image # post /trips/:id/image
# byebug
#     # send file to cloudinary
#   end

  private

  def trip_params
    params.require(:trip).permit(:title, :journal, :date, :distance, :duration, :title_image_input, photos: []) #disallow mountain_ids:[], hiker_ids:[])  
  end

  def find_and_authorize_trip
    @trip = Trip.find params[:id]
    authorize @trip
  end

  def find_and_authorize_edit_vars
    @mountains   = policy_scope(Mountain)
    @friends     = current_hiker.friends_and_self # remove if current_hiker
    @site_hikers = Hiker.all - @friends
  end

  def create_or_update_trip
    @trip = params[:id] ? Trip.find(params[:id]) : Trip.new
    authorize @trip

    # dont let disabled select widget wipe out these
    mountain_ids = params[:trip].delete(:mountain_ids)
    hiker_ids    = params[:trip].delete(:hiker_ids)
    
    @trip.attributes = trip_params

    @trip.update_mountains mountain_ids
    added_hikers_ids =  @trip.update_hikers hiker_ids

    if @trip.save
      @trip.associate_photos_with current_hiker
      flash_no_mountains
      redirect_to @trip, success: 'Trip saved'
      true
    end
  end

  def flash_no_mountains
    flash[:alert] = "You've saved a trip with no mountains selected" if @trip.mountains.empty?
  end

  def send_added_hiker_emails( ids )
    hikers = Hiker.find ids
    hikers.each do |hiker|
      HikerMailer.added_email( hiker, @trip).deliver
    end
  end

end

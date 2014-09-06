class TripsController < ApplicationController
  before_action :save_back, only: [:new, :edit]

  after_action :verify_authorized, :except => [:index, :me, :everyone]
  after_action :verify_policy_scoped, :only => [] #[:index, :me, :everyone]

  def index # default: friends 
    redirect_to everyone_trips_path unless current_user
    @trips = current_hiker.friends.map {|hiker| hiker.trips }.flatten.uniq.sort {|a,b| b.date <=> a.date }
  end
  def me
    redirect_to everyone_trips_path unless current_user
    @trips = current_hiker.trips.order("date DESC")
    render :index
  end
  def everyone
    @trips = Trip.order("date DESC")
    # clean this up!
    @trips.to_a.delete_if {|t| t.hiker_ids.blank? }
    render :index
  end

  def show
    find_and_authorize_trip
  end

  def new
    @trip = Trip.new
    authorize @trip
    @trip.hikers << current_hiker
    find_and_authorize_edit_vars
    gon.current_hiker_id = current_hiker.id
  end

  def edit
    find_and_authorize_trip
    find_and_authorize_edit_vars
    gon.current_hiker_id = current_hiker.id
  end

  def create
    render :new unless create_or_update_trip
  end

  def update
  # byebug
    render :edit unless create_or_update_trip
  end

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
  # byebug
    @trip = params[:id] ? Trip.find(params[:id]) : Trip.new
    authorize @trip

    if params[:delete]
      # trip is deleted when all hikers removed, but also hiker_ids == [''] when not changed b/c the widget is disabled, so added a separate params[:delete] to indicate deletion. (todo: just use DELETE verb and action from form sumbit)
      @trip.hiker_ids = nil
      @trip.save
      redirect_to newsfeed_path, notice: 'Trip removed'
      return true
    end
        
    # dont let disabled select widget wipe out these
    mountain_ids = params[:trip].delete(:mountain_ids)
    hiker_ids    = params[:trip].delete(:hiker_ids)
    
    @trip.attributes = trip_params

    @trip.update_mountains mountain_ids

    added_hikers_ids =  @trip.update_hikers hiker_ids

    if @trip.save
      @trip.associate_photos_with current_hiker
      send_added_hiker_emails added_hikers_ids
      flash_no_mountains
      redirect_to @trip, success: 'Trip saved'
      true
    end
  end

  def flash_no_mountains
    flash[:alert] = "You've saved a trip with no mountains selected" if @trip.mountains.empty?
  end

  def send_added_hiker_emails( ids )
    ids -= [current_hiker.id.to_s]
    hikers = Hiker.find( ids).select {|h| !h.disable_notifications }
    hikers.each do |hiker|
      HikerMailer.added_email( hiker, @trip).deliver
    end
    flash[:notice] = "An email notification has been sent to #{hikers.map(&:first_name).to_sentence}" if hikers.present?
  end

end

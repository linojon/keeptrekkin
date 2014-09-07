class HikersController < ApplicationController

  def show
    find_and_authorize_hiker
    @mountains = params[:all] ? Mountain.all : @hiker.mountains.uniq
  end

  def edit
    find_and_authorize_hiker
  end

  def update
    find_and_authorize_hiker
    if @hiker.update_attributes(hiker_params)
      current_hiker.create_activity :update, owner: current_hiker
      redirect_to @hiker, notice: 'Hiker profile updated'
    else
      flash.now[:error] = 'There was a problem saving the profile. Please try again.'
      render :edit
    end
  end

  def create
    # xhr request
    if @hiker = Hiker.where( email: params[:hiker][:email] ).first
      # already exists with this email, just use it, ignore name
      authorize @hiker
      render json: @hiker
    else
      @hiker = Hiker.new hiker_params
      authorize @hiker
      if @hiker.save
        @hiker.create_activity :create, owner: current_hiker
        render json: @hiker
      else
        render json: @hiker, status: :unprocessable_entity
      end
    end
  end

  private

  def hiker_params
    params.require(:hiker).permit(:email, :name, :profile_image_input, :location, :disable_notifications)
  end

  def find_and_authorize_hiker
    @hiker = Hiker.find params[:id]
    authorize @hiker
  end

end

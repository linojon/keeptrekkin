class HikersController < ApplicationController

  def show
    find_and_authorize_hiker
  end

  def edit
    find_and_authorize_hiker
  end

  def update
    find_and_authorize_hiker
    if @hiker.update_attributes(hiker_params)
      redirect_to @hiker, notice: 'Hiker profile updated'
    else
      flash.now[:error] = 'There was a problem saving the profile. Please try again.'
      render :new
    end
  end

  def create
    # xhr request
# byebug
    if @hiker = Hiker.where( email: params[:hiker][:email] ).first
      # already exists with this email, just use it, ignore name
      authorize @hiker
      render json: @hiker
    else
      @hiker = Hiker.new hiker_params
      authorize @hiker
      if @hiker.save
        render json: @hiker
      else
        render json: @hiker, status: :unprocessable_entity
      end
    end
  end

  private

  def hiker_params
    params.require(:hiker).permit(:email, :name)
  end

  def find_and_authorize_hiker
    @hiker = Hiker.find params[:id]
    authorize @hiker
  end

end

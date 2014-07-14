class PagesController < ApplicationController
  skip_after_action :verify_authorized

  def home
    if Rails.env.development? && params[:hiker_id]
      redirect_to "/session/create?hiker_id=#{params[:hiker_id]}"
    else
      redirect_to dashboard_path, flash: flash if current_user
    end
  end
  
end

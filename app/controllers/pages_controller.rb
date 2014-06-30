class PagesController < ApplicationController

  def home
    if Rails.env.development? && params[:hiker_id]
      redirect_to "/session/create?hiker_id=#{params[:hiker_id]}"
    else
      redirect_to dashboard_path if current_user
    end
  end
  
end

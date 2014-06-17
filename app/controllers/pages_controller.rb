class PagesController < ApplicationController

  def home
    redirect_to trips_path if current_user
  end
  
end

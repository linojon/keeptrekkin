class ApplicationController < ActionController::Base
  # vvvvvv parkerhill standard  vvvvvv

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  # vvvvvv app specific vvvvvv

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_hiker
    current_user.hiker
  end

  helper_method :current_user, :current_hiker

end

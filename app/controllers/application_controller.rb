class ApplicationController < ActionController::Base
  # vvvvvv parkerhill standard  vvvvvv

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end


  # http://railscasts.com/episodes/131-going-back
  def back_path
    request.env['HTTP_REFERER'] || root_path
  end

  # e.g. before_action :save_back, only: [:new, :edit]
  def save_back
    session[:last_page] = back_path
  end

  # eg link_to 'Continue from before', saved_back_path if saved_back_path
  def saved_back_path
    session[:last_page]
  end
  helper_method :back_path, :save_back, :saved_back_path


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

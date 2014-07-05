class ApplicationController < ActionController::Base
  # vvvvvv parkerhill standard  vvvvvv

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  include Pundit
  # after_action :verify_authorized, :except => :index
  # after_action :verify_policy_scoped, :only => :index
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  # http://railscasts.com/episodes/131-going-back
  def back_path
    request.referrer || root_path
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

  # config/application.rb
  def app_title
    Rails.application.config.app_title
  end
  helper_method :app_title

  # vvvvvv app specific vvvvvv

  private
  # vvvvvv parkerhill standard vvvvvv

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end


  # vvvvvv app specific vvvvvv
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def current_hiker
    current_user && current_user.hiker
  end
  helper_method :current_user, :current_hiker

end

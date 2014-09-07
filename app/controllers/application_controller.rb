class ApplicationController < ActionController::Base

  # vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  # vvvvvv parkerhill standard  vvvvvv
  public
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :error

  # decent_configuration do
  #   strategy DecentExposure::StrongParametersStrategy
  # end

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

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

  # config/application.rb
  def app_title
    Rails.application.config.app_title
  end
  helper_method :back_path, :save_back, :saved_back_path, :app_title

  protected
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def record_not_found(exception)
    redirect_to request.referrer||root_url, error: "Page not found"
  end

  # vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  # vvvvvv pundit specific vvvvvv
  public
  include Pundit
  def pundit_user
    current_hiker
  end
  after_action :verify_authorized, :except => :index
  after_action :verify_policy_scoped, :only => :index
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end

  include PublicActivity::StoreController

  protected
  def user_not_authorized(exception)
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end


  # # vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  # # vvvvvv devise specific vvvvvv
  # public
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  # end

  # vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  # vvvvvv app specific vvvvvv
  public
  def current_hiker
    current_user && current_user.hiker
  end
  helper_method :current_hiker
  hide_action :current_hiker # so its not considered an action, should do this for all public ApplicationController methods (or make them private)

  protected
end

class SessionsController < ApplicationController
  skip_after_action :verify_authorized
  
  def hack
    redirect_to root_url unless Rails.env.development? && params[:id]

    hiker = Hiker.find params[:id]
    user = (hiker.user ||= User.create )
    hiker.save
    session[:user_id] = user.id
    flash_edit_profile user
    redirect_to newsfeed_url
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash_edit_profile user
    redirect_to newsfeed_url
  end

  # def create
  #   auth = env["omniauth.auth"]
  #   # already registered
  #   if user = User.where uid: auth.uid
  #     update user info
  #     session[:user_id] = user.id
  #     redirect_to newsfeed_path

  #   # invited with this email
  #   elsif user = User.where(email: auth.info.email).first
  #     update user info
  #     session[:user_id] = user.id
  #     redirect_to newsfeed_path
      

  #   # # maybe invited?
  #   # else
  #   #   matches = Hiker.not_authenticated.fuzzy( auth.info.name, auth.info.email )
  #   #   go to a page (popup) asking if ou are one of the matches
  #   #     click one posts to /hikers/id:/authenticate/uid
  #   #     which recreates a user for hike and redirect to /auth/facebook (again)

  #   # unknown, create a new user
  #   else
  #     create user
  #     create hiker
  #     redirect_to newsfeed_path
  #   end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def flash_edit_profile(user)
    flash[:success] = "Welcome #{current_hiker.name}! You can #{view_context.link_to 'edit your profile', edit_hiker_path(current_hiker)} now.".html_safe if (user.updated_at - user.created_at) < 0.1 # e.g new user
  end
  
end
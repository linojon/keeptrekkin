class SessionsController < ApplicationController

  # def create
  #   auth = env["omniauth.auth"]
  #   # already registered
  #   if user = User.where uid: auth.uid
  #     update user info
  #     session[:user_id] = user.id
  #     redirect_to dashboard_path

  #   # invited with this email
  #   elsif user = User.where(email: auth.info.email).first
  #     update user info
  #     session[:user_id] = user.id
  #     redirect_to dashboard_path
      

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
  #     redirect_to dashboard_path
  #   end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to dashboard_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
end
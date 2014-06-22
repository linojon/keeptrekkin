class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to dashboard_url
  end

  # def create
  #   auth = env["omniauth.auth"]
  #   user = User.where uid: auth.uid
  #   if user_id
  #     session[:user_id] = user.id
  #     redirect_to root_url
  #   else
  #     matches = Hiker.not_authenticated.matches_for( auth.info.name, auth.info.email )
  #     # (pop up) (page) asking if you are one of the matches
  #     # click one posts to /hikers/id:/authenticate/uid
  #     #  which recreates a user for hike and redirect to /auth/facebook (again)
  #   # else
  #     # creates a hiker with given auth 
  #   end

  #   # user = User.from_omniauth(env["omniauth.auth"])
  #   # session[:user_id] = user.id
  #   # redirect_to dashboard_url
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  
end
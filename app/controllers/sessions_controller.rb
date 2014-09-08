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
# byebug
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.hiker
      flash_edit_profile user
      user.hiker.create_activity :logged_in, owner: current_hiker
      redirect_to newsfeed_url
    else
      redirect_to who_sessions_path
    end
  end

  def who
# byebug
    if current_user.nil?
      redirect_to root_url
    else
      @hikers = Hiker.has_no_user.fuzzy( name: current_user.name, email: current_user.email )
    end
  end

  def iam
# byebug
    if current_user.nil?
      redirect_to root_url

    elsif params[:id] == 'new'
      current_user.create_hiker name: current_user.name, email: current_user.email
      current_user.hiker.create_activity :signed_up_new, owner: current_hiker
      flash_edit_profile(current_user)
      redirect_to newsfeed_url

    elsif hiker = Hiker.find( params[:id])
      current_user.hiker = hiker
      current_user.save
      hiker.create_activity :signed_up_iam, owner: current_hiker
      flash_edit_profile(current_user)
      redirect_to newsfeed_url

    else
      session[:user_id] = nil
      redirect_to root_url, alert: "I'm sorry, unable to connect and sign in"
    end
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
    current_hiker.create_activity :logged_out, owner: current_hiker
    session[:user_id] = nil
    redirect_to root_url
  end

  private

  def flash_edit_profile(user)
    flash[:info] = "Welcome #{current_hiker.name}! You can #{view_context.link_to 'edit your profile', edit_hiker_path(current_hiker)} now.".html_safe if (user.updated_at - user.created_at) < 0.1 # e.g new user
  end
  
end
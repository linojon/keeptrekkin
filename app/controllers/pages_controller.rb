class PagesController < ApplicationController
  skip_after_action :verify_authorized

  def home
    if Rails.env.development? && params[:hiker_id]
      redirect_to "/session/create?hiker_id=#{params[:hiker_id]}"
    elsif current_user
      flash = flash # pay it forward
      redirect_to newsfeed_path
    end
  end

  def legalese
  end

  def test_email
    HikerMailer.test_email( current_hiker ).deliver
    redirect_to newsfeed_url, notice: 'Email sent'
  end
  
end

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
    return( redirect_to root_path ) unless current_user
    HikerMailer.test_email( current_hiker ).deliver
    redirect_to newsfeed_url, notice: 'Email sent'
  end

  def broadcast_email
    return( redirect_to root_path ) unless current_user
    if request.post?
      who = params[:contact][:email]
      if who == 'all'
        hikers = Hiker.find( User.all.select(:hiker_id).map(&:hiker_id) ) # all registered hikers
      elsif who.to_i > 0
        hikers = Array( Hiker.find who.to_i)
      end
      if hikers.blank?
        return redirect_to( back_path, notice: 'Broadcast email not sent. Invalid Hiker ID')
      end
      hikers.each do |hiker|
        next if hiker.email.blank? # eg Matt id 9 
        HikerMailer.broadcast_email( hiker, params[:contact][:name], params[:contact][:message] ).deliver
      end
      redirect_to( back_path, notice: "Broadcast emails sent to #{hikers.size} recipients")
    end
  end
  
end

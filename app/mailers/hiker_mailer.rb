class HikerMailer < ActionMailer::Base
  default from: "noreply@keeptrekkin.com"

  def added_email(hiker, trip)
    @hiker = hiker
    @trip  = trip
    @url   = root_url #( only_path: false )
    mail to: @hiker.email, subject: "Hello Hiker! You've been added to a trip"
  end

end

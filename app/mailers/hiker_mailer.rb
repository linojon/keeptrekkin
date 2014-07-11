class HikerMailer < ActionMailer::Base
  default from: "KeepTrekkin <noreply@keeptrekkin.com>"

  def added_email(hiker, trip)
    @hiker = hiker
    @trip  = trip
    @url   = root_url #( only_path: false )
    to_email  = 'linojon@gmail.com' #@hiker.email
    to        = "#{hiker.name} <#{to_email}>"
    mail to: to, subject: "Hello Hiker! You've been added to a trip"
  end

end

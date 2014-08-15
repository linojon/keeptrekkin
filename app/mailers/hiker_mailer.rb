class HikerMailer < ActionMailer::Base
  default from: "KeepTrekkin <noreply@keeptrekkin.com>"
  # default from: "KeepTrekkin <app26373640@heroku.com>"

  def added_email(hiker, trip)
    @hiker = hiker
    @trip  = trip
    @url   = root_url #( only_path: false )
    if Rails.env.test?
      to_email  = @hiker.email
    else
      to_email  = @hiker.email #'linojon@gmail.com'
    end
    to        = "#{hiker.name} <#{to_email}>"
    mail to: to, subject: "Hello Hiker! You've been added to a trip"
  end

  def test_email(hiker)
    @hiker = hiker
    @url   = root_url
    to     = "#{hiker.name} <#{hiker.email}>"
    mail to: to, subject: "Test from Keeptrekkin"
  end

end

class User < ActiveRecord::Base

  has_one :hiker

  def self.from_omniauth(auth)
    #logger.info auth
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!

      user.create_and_update_hiker(auth)
    end
  end

  def create_and_update_hiker(auth)
    h = hiker || build_hiker
    h.name  ||= auth.info.name
    h.email ||= auth.info.email
    h.profile_image_url ||= auth.info.image.gsub('square','large') #200x200
    h.profile_chip_url  ||= auth.info.image.gsub('square', 'width=30&height=30')
    h.save
  end

end

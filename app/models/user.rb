class User < ActiveRecord::Base

  belongs_to :hiker

  def self.from_omniauth(auth)
    #logger.info auth

    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      # TODO: decide what/if attributes updated from provider or left if user exists
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!

      user.create_or_update_hiker( 
        name: auth.info.name, 
        email: auth.info.email,
        profile_image_url: auth.info.image.gsub('square','large'), #200x200
        profile_chip_url: auth.info.image.gsub('square', 'width=30&height=30')
      )
    end
  end

  def create_or_update_hiker(attributes)
    if self.hiker
      self.hiker.update_attributes_only_if_blank attributes
    else
      self.create_hiker attributes
    end
  end

end

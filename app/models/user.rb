class User < ActiveRecord::Base

  belongs_to :hiker

  def self.from_omniauth(auth)
    logger.info auth

    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      # byebug
      # user attribs update from provider, hiker attribs are only initialized then user edits
      user.provider = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.email            = auth.info.email
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.profile_url      = auth.info.urls['Facebook']
      user.image_url        = auth.info.image.split('?').first
      #auth.info.image.gsub('square','large'), #200x200
      # profile_chip_url: auth.info.image.gsub('square', 'width=30&height=30')
      user.save!

      # can we pull location from facebook?

      user.create_or_update_hiker( 
        name:  auth.info.name, 
        email: auth.info.email
      )
    end
  end

  def create_or_update_hiker(attributes)
    if self.hiker
      self.hiker.update_attributes_only_if_blank attributes
    elsif hiker = Hiker.where(email: attributes[:email]).first
      self.hiker = hiker
      self.save!
    # else
    #   self.create_hiker attributes
    end
  end

  def profile_image_url
    image_url + '?width=300&height=200' if image_url
  end

  def chip_image_url
    image_url + '?width=30&height=30' if image_url
  end


end

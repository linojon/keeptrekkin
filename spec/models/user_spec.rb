require 'rails_helper'

describe User do
  
  describe 'create .from_omniauth' do
    let(:data) { facebook_omniauth_hash }
    let(:user) { User.from_omniauth( data ) }
    let(:hiker) { user.hiker }

    it 'captures facebook data' do
      expect(user).to be_valid
      expect(user).to be_persisted
      expect(user.provider).to eql 'facebook'
    end

    it 'creates a hiker' do
      expect(hiker).to be_valid
      expect(hiker).to be_persisted
      expect(hiker.name).to eql data[:info][:name]
      expect(hiker.email).to eql data[:info][:email]
      expect(hiker.profile_image_url).to eql data[:info][:image].gsub('square','large')
      expect(hiker.profile_chip_url).to eql data[:info][:image].gsub('square','width=30&height=30')
    end
  end
end

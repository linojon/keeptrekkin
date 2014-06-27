require 'rails_helper'

feature 'New user signs up via Facebook' do
  let(:name) { 'Jonathan Example' }
  let(:email) { 'jonathan@example.com' }
  let(:omniauth) { facebook_omniauth_hash name: name, email: email }

  background do
    mock_facebook_omniauth name: name, email: email
    visit '/'
    click_on 'Sign in via Facebook'
  end

  context 'First time sign up' do

    it "has Sign out link" do 
      expect(page).to have_content('Sign out')
    end
    it "redirects to dashboard" do
      expect(current_url).to include '/dashboard'
    end
    it "creates user with oauth info" do
      user = User.last
      expect(user.provider).to eql 'Facebook'
      expect(user.uid).to eql omniauth.uid
    end
    it "creates hiker with name, email associated with user" do
      hiker = Hiker.last
      expect(hiker.name).to eql omniauth.info.name
      expect(hiker.email).to eql omniauth.info.email
      expect(hiker.user).to_not be_nil
      expect(hiker.user.uid).to eql omniauth.uid
    end
    it "sets user avatar"
  end
end
    

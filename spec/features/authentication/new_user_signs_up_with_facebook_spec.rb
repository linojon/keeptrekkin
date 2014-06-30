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

    scenario "has Sign out link and redirects to dashboard" do 
      expect(page).to have_content('Sign out')
      # TODO: user name and link to profile
      expect(current_url).to include '/dashboard'
    end
    scenario "creates user with oauth info" do
      user = User.last
      expect(user.provider).to eql 'facebook'
      expect(user.uid).to eql omniauth.uid
    end
    scenario "creates hiker with name, email associated with user" do
      hiker = Hiker.last
      expect(hiker.name).to eql omniauth.info.name
      expect(hiker.email).to eql omniauth.info.email
      expect(hiker.user).to_not be_nil
      expect(hiker.user.uid).to eql omniauth.uid
    end
    scenario "sets user avatar"
  end
end
    

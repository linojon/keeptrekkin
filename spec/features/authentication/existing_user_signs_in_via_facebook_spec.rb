require 'rails_helper'

feature 'Existing user signs in via Facebook' do
  let(:hiker) { create :hiker, :with_user }

  background do
    mock_facebook_omniauth name: hiker.name, email: hiker.email
    visit '/'
    click_on 'Sign in via Facebook'
  end

  it "signed in and redirects to newsfeed" do
    within 'nav.navbar' do
      expect(page).to have_content('Sign out')
      expect(page).to have_content(hiker.name)
      expect(page).to have_selector('img.chip') # src=/assets/profile-small.jpg
    end
    expect(current_url).to include '/newsfeed'
  end

  it "signs in with invalid credentials"
   # OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
end

require 'rails_helper'

feature 'Existing user signs in via Facebook' do
  let(:hiker) { create :hiker, :with_user }

  background do
    mock_facebook_omniauth name: hiker.name, email: hiker.email
    visit '/'
    click_on 'Sign in via Facebook'
  end

  it "signed in and redirects to newsfeed" do
    expect(page).to have_content('Sign out')
    # TODO: user name and link to profile
    expect(current_url).to include '/newsfeed'
  end
end

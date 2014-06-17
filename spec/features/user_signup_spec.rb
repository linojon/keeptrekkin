require 'rails_helper'

feature 'user sign in' do
  background do
    #request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    visit '/'
  end

  scenario "first time sign up" do
    within 'nav' do
      click_on 'Sign in via Facebook'
    end
    # creates user
    # creates hiker
    # initializes user and hiker info
    # redirects to trips
    debugger
    expect(page).to have_content('Sign out')
  end

  xscenario "existing user"
    # click sign in button
    # finds current_user
    # redirects to trips

  xscenario "invited user via link"
    # click sign in button
    # finds user and hiker
    # initializes user and hiker info
    # redirects to trips

  xscenario "invited user via sign in"
    # click sign in button
    # finds user and hiker
    # initializes user and hiker info
    # redirects to trips

  xscenario "invited user via sign in where fb email doesnt match but name does"
    # click sign in button
    # finds user and hiker
    # initializes user and hiker info
    # redirects to trips

  xscenario "invited via link does not work when current user"

  xscenario "failure from Facebook login"

end
require 'rails_helper'

feature 'user sign in' do
  # Given:
  background do
    visit '/'
  end

  scenario "first time sign up" do
    # When:
    within 'nav' do 
      click_on 'Sign in via Facebook'
    end

    # Then:
    # facebook dialogs to Verify you're the person, Share some personal info, our privacy policy ??
    # creates user
    # creates hiker
    # initializes user and hiker info
    expect(page).to have_content('Sign out')
    # redirects to dashboard
    expect(current_url).to include '/dashboard'
  end

  xscenario "existing user"
    # When: click sign in button

    # Then:
    # finds current_user
    # redirects to dashboard

  xscenario "invited user via link"
    # When: click sign in button

    # Then:
    # finds user and hiker
    # initializes user and hiker info
    # redirects to trip

  xscenario "invited user via sign in"
    # When: click sign in button

    # Then:
    # finds user and hiker
    # initializes user and hiker info
    # redirects to dashboard

  xscenario "invited user via sign in where fb email doesnt match but name does"
    # When: click sign in button

    # Then:
    # finds user and hiker
    # initializes user and hiker info
    # redirects to trips

  xscenario "invited via link does not work when current user"
    # Given: signed in
    # When: click sign in button
    # Then: stay signed in, redirects to dashboard

  xscenario "failure from Facebook login"
    # When: click signin button wit FB failure
    # Then fails gracefully, flash message

  xscenario "sign up asks to confirm or change name and email"

end
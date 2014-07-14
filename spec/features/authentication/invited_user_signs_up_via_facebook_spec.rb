require 'rails_helper'

feature 'Invited user signs up via Facebook' do
  context "matching email address" do
    let(:hiker) { create :hiker }

    background do
      mock_facebook_omniauth name: hiker.name, email: hiker.email
      visit '/'
      click_on 'Sign in via Facebook'
    end

    scenario "creates user associated by email with existing hiker" do
      hiker.reload
      expect(hiker.user).to_not be_nil
    end
    scenario 'signed in and redirects to dashboard' do
      expect(page).to have_content('Sign out')
      # TODO: user name and link to profile
      expect(current_url).to include '/dashboard'
    end
    scenario "flash prompt to edit profile" do
      within ".alert" do
        expect(page).to have_content "Welcome #{hiker.name}! You can edit your profile now"
        expect(page).to have_link 'edit your profile', href: "/hikers/#{hiker.id}/edit"
      end
    end
  end

  scenario "doesnt find email, tries to match name"

end
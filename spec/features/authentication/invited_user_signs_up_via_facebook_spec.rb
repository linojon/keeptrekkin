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
    scenario 'signed in and redirects to newsfeed' do
      expect(page).to have_content('Sign out')
      # TODO: user name and link to profile
      expect(current_url).to include '/newsfeed'
    end
    scenario "flash prompt to edit profile" do
      within ".alert" do
        expect(page).to have_content "Welcome #{hiker.name}! You can edit your profile now"
        expect(page).to have_link 'edit your profile', href: "/hikers/#{hiker.id}/edit"
      end
    end
  end

  context "doesnt find email, it suggests unregistered hikers", js: true do
    let!(:hiker)   { create :hiker, name: 'Jonathan Linowes', email: 'jonathan@example.com' }
    let!(:hiker2) { create :hiker, name: 'Jonathan', email: 'otheremail@foobar.com' }
    let!(:hiker3) { create :hiker, name: 'Linojon', email: 'linojon@gmail.com' }
    let!(:hiker4) { create :hiker, name: 'Unrelated Smith', email: 'foo@bar.com' }

    background do
      mock_facebook_omniauth name: 'jlinowes', email: 'jlinowes@syr.edu'
      visit '/auth/facebook'
    end

    scenario 'user picks one' do
      click_on 'Linojon (linojon@...)'
      expect(current_url).to include '/newsfeed'
      within 'nav.navbar' do
        expect(page).to have_content('Sign out')
        expect(page).to have_content('Linojon')
      end
    end

    scenario 'clicks New' do
      click_on "Nope, none of these, I'm new" # 'im_new'
      expect(page).to have_content('Sign out')
      expect(page).to have_content('jlinowes')
    end

    scenario 'clicks Cancel' do
      click_on 'Never mind'
      expect(page).to have_content('Sign in via Facebook') 
    end

    # scenario 'user inputs his invitation email'

  end

end
require 'rails_helper'

feature 'invite hiker' do

  feature 'dialog behavior', js: true do
    # Given I am signed in and editing a trip
    # And I opened the invite hiker dialog
    let(:trip) { create :trip_with_hiker }
    background do
      # byebug
      sign_in hiker: trip.hikers.first
      visit "/trips/#{trip.id}/edit"
      find('#enable_edit_hikers').click
      click_on 'Add hiker'
      click_on 'Invite'
      expect(page).to have_content 'Editing Trip'
    end

    scenario "email validation format"

    scenario "autofill name based on email" do
      fill_in 'hiker_email', with: 'linojon@gmail.com'
      page.execute_script("$('#hiker_email').trigger('change');") # shouldn't need this
      expect(find_field('hiker_name').value).to eql 'Linojon'
    end
  end

  scenario 'when creating a trip'

  scenario 'when editing a trip'

end

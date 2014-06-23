require 'rails_helper'

feature 'invite hiker dialog', js: true do

  # Given I am signed in and editing a trip
  # And I opened the invite hiker dialog
  let(:trip) { create :trip_with_hiker }

  def fill_in_email_with(email)
    fill_in 'hiker_email', with: email
    page.execute_script("$('#hiker_email').trigger('change');") # shouldn't need this
  end

  background do
    # byebug
    sign_in hiker: trip.hikers.first
    visit "/trips/#{trip.id}/edit"
    find('#enable_edit_hikers').click
    click_on 'Add hiker'
    click_on 'Invite'
    expect(page).to have_content 'Editing Trip'
  end

  scenario "email format validation" do
    fill_in_email_with 'linojon@gmail.com'
    within('#invite_hiker_dialog') do
      expect(page).to have_selector '#hiker_name'
    end
    fill_in_email_with 'linojon'
    within('#invite_hiker_dialog') do
      expect(page).to have_no_selector '#hiker_name'
    end
    fill_in_email_with 'linojon@gmail'
    within('#invite_hiker_dialog') do
      expect(page).to have_no_selector '#hiker_name'
    end
    fill_in_email_with ''
    within('#invite_hiker_dialog') do
      expect(page).to have_no_selector '#hiker_name'
    end
    fill_in_email_with 'linojon@gmail.com'
    within('#invite_hiker_dialog') do
      expect(page).to have_selector '#hiker_name'
    end
  end
  scenario "autofill name based on email" do
    fill_in_email_with 'linojon@gmail.com'
    expect(find_field('hiker_name').value).to eql 'Linojon'
  end

  scenario "doesnt allow duplicate hikers in trip"

end

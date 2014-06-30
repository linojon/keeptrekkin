require 'rails_helper'

feature 'User dashboard' do
  let!(:hiker)       { create :hiker, :with_user }
  let!(:trip1)       { create :trip, :with_mountain }
  let!(:trip2)       { create :trip, :with_mountain }
  let!(:other_trip)  { create :trip, :with_hiker }

  background do
    trip1.hikers << hiker
    trip2.hikers << hiker
    sign_in hiker
    expect(current_url).to include '/dashboard'
  end

  scenario 'shows own trips' do
    expect(page).to have_content trip1.title
    expect(page).to have_content trip2.title
    expect(page).to have_no_content other_trip.title
  end

end


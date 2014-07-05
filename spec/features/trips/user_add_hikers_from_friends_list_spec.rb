require 'rails_helper'

feature 'User adds hiker from friends list', js: true, areyousure: true do
  let(:hiker)    { create :hiker, :with_user }
  let(:friend1) { create :hiker, :with_user }
  let(:friend2) { create :hiker, :with_user }
  let(:other_trip) { create :trip }

  background do
    other_trip.hikers << [hiker, friend1, friend2]
    sign_in hiker
    click_on 'Add a Trip'
  end

  scenario 'using Select Hikers button' do
    click_on 'Select Hikers'
    ele = page.find('.selection_item', text: friend1.name)
    ele.click
    click_on 'Save', match: :first
    trip = Trip.unscoped.order(:created_at).last
    expect(trip.hikers).to match_array [hiker, friend1] 
  end

  scenario 'using search' do
    lastname1 = friend1.name.split(' ').last
    lastname2 = friend2.name.split(' ').last
    fill_in 's2id_autogen2', with: lastname1 # aka Search field
    expect(page).to have_selector('.selection_item', text: lastname1)
    expect(page).to have_no_selector('.selection_item', text: lastname2)
    ele = page.find('.selection_item', text: friend1.name)
    ele.click
    click_on 'Save', match: :first
    trip = Trip.unscoped.order(:created_at).last
    expect(trip.hikers).to match_array [hiker, friend1] 
  end

end
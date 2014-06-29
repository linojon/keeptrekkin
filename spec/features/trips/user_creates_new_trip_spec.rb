require 'rails_helper'

feature 'User creates new trip', js: true do
  let(:hiker) { create :hiker, :with_user }

  background do
    sign_in hiker
  end

  scenario 'default values when nothing entered' do
    # create an 'empty' trip
    click_on 'Add a Trip' 
    click_on 'Save', match: :first
    trip = Trip.last

    # adds me as hiker
    expect(trip.hikers).to match_array [hiker]
    # sets todays date
    expect(trip.date).to eql Date.today
    # redirect to show view
    expect(current_url).to include "/trips/#{trip.to_param}"
  end

  scenario 'filled out form' do
    mountain = create :mountain
    hiker2 = create :hiker
    click_on 'Add a Trip'

    fill_in 'Title', with: 'This is my trip'
    select mountain.name, from: 'Mountains'
    select hiker2.name, from: 'Hikers'
    fill_in 'Date', with: '2014-6-1'
    fill_in 'Distance Hiked', with: '7.7 miles'
    fill_in 'Duration', with: '4 hours'
    fill_in 'Journal', with: 'We had a great time.'
    click_on 'Save', match: :first

    trip = Trip.last
    expect(trip.title).to eql 'This is my trip'
    # etc
  end

  scenario 'cancels' do
    click_on 'Add a Trip'
    click_on 'Cancel', match: :first
    expect(current_url).to include '/dashboard'
  end

end

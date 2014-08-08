require 'rails_helper'

feature 'User adds photos to trip', js: true, areyousure: true, attachinary: true do
  let(:hiker) { create :hiker, :with_user }
  background do
    sign_in hiker
  end

  # scenario 'new trip, no photos' do
  #   click_on 'Add a Trip'
  #   Capybara.ignore_hidden_elements = false
  #   # click_on 'Upload Photo'
  #   attach_file 'trip_photos', File.join(Rails.root, 'spec', 'support', 'obiwan.jpg')
  #   click_on 'Save', match: :first
  #   Capybara.ignore_hidden_elements = true

  #   trip = Trip.last
  #   expect(trip.photos.count).to eql 1
  #   expect(trop.photos.first.filename).to eql 'obiwan.jpg'
  # end

  # scenario 'new trip, additional photos'
  # scenario 'uploads photo as temporary and shows thumbnail'
  # scenario 'can remove unsaved photo'
  # scenario 'saves photos when saved'
  # scenario 'saved photos belong to trip and current user'

  # context 'edit existing' do
  #   let(:trip) { create :trip, :with_photo, hikers: [hiker] }
  #   before :each do
  #     visit "/trips/#{trip.to_param}/edit"
  #   end

  #   scenario 'can remove existing photo' do
  #     byebug
  #   end

  #   scenario 'can add new photo'
  #   scenario 'saves'
  #   scenario 'doesnt save added photos when cancel'
  #   scenario 'removed files are deleted from database'
  # end

end

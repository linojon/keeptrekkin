require 'rails_helper'

feature 'Adding hikers sends email', js: true, areyousure: true do
  let(:me)     { create :hiker, :with_user }
  let(:hiker1) { create :hiker, :with_user }
  let(:hiker2) { create :hiker, :with_user }
  let(:other_trip) { create  :trip }

  context 'new trip' do
    background do
      other_trip.hikers << [me, hiker1, hiker2]
      sign_in me
      click_on 'Add a Trip'
      click_on 'Select Hikers'
      page.find('.selection_item', text: hiker1.name).click
    end

    scenario "adding a friend hiker" do
      expect{ click_on 'Save', match: :first }.to change{ ActionMailer::Base.deliveries.size }.by(2)
    end

    scenario 'adding two hikers' do
      click_on 'Select Hikers'
      page.find('.selection_item', text: hiker2.name).click
      expect{ click_on 'Save', match: :first }.to change{ ActionMailer::Base.deliveries.size }.by(3)
    end
  end

  context 'existing trip' do
    let!(:trip)        { create :trip, :with_hiker }
    let(:me)        { trip.hikers.first }

    background do
      [hiker1, hiker2]
      sign_in me
      visit "/trips/#{trip.to_param}/edit"
      find('#enable_edit_hikers').click
      click_on 'Select Hikers'
      page.find('.selection_item', text: hiker1.name).click
    end

    scenario 'adding one hiker' do
      expect{ click_on 'Save', match: :first }.to change{ ActionMailer::Base.deliveries.size }.by(1)
    end

  end

end
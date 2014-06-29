require 'rails_helper'

feature 'User adds mountains to trip', js: true do
  let!(:mountain) { create :mountain }
  let!(:mountain2) { create :mountain }
  let(:trip) { Trip.last }

  background do
    sign_in
  end

  scenario 'new trip, no mountains selected' do
    click_on 'Add a Trip'
    select mountain.name, from: 'Mountain(s)'
    click_on 'Save', match: :first
    expect(trip.mountains).to match_array [mountain]
  end 

  scenario 'new trip, additional mountains' do
    click_on 'Add a Trip'
    select mountain.name, from: 'Mountain(s)'
    select mountain2.name, from: 'Mountain(s)'
    click_on 'Save', match: :first
    expect(trip.mountains).to match_array [mountain, mountain2]
  end

  scenario 'save new with no mountains gives warning' do
    click_on 'Add a Trip'
    click_on 'Save', match: :first
    expect(page).to have_content "You've saved a trip with no mountains selected"
  end

  context 'editing existing' do
    background do
      # save with no mountains
      click_on 'Add a Trip'
      click_on 'Save', match: :first
      visit "/trips/#{trip.to_param}/edit"
    end

    scenario 'edit, mountains disabled unless empty' do
      # edit and add one mountain
      select mountain.name, from: 'Mountain(s)'
      click_on 'Save', match: :first
      expect(trip.reload.mountains).to match_array [mountain]
      # edit and moutains select are disabled
      visit "/trips/#{trip.to_param}/edit"
      expect(page).to have_selector('#s2id_trip_mtns_select.select2-container-disabled')
      # enable by clicking pencil icon and add another
      page.find('#enable_edit_mtns').click
      expect(page).to have_no_selector('#s2id_trip_mtns_select.select2-container-disabled')
      select mountain2.name, from: 'Mountain(s)'
      click_on 'Save', match: :first
      expect(trip.reload.mountains).to match_array [mountain, mountain2]
    end
   
    scenario 'save editing with no mountains gives warning' do
      select mountain.name, from: 'Mountain(s)'
      click_on 'Save', match: :first
      # delete selected mountain
      visit "/trips/#{trip.to_param}/edit"
      page.find('#enable_edit_mtns').click
      page.find('a.select2-search-choice-close').click
      click_on 'Save', match: :first
      expect(page).to have_content "You've saved a trip with no mountains selected"
    end
  end

end

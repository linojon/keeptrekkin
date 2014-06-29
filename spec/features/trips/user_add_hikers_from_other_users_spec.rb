require 'rails_helper'

feature 'User adds hiker from other users', js: true do
  let(:hiker)    { create :hiker, :with_user }
  let(:other1) { create :hiker, :with_user }
  let(:other2) { create :hiker, :with_user }

  let(:lastname)  { other1.name.split(' ').last }

  background do
    sign_in hiker
    click_on 'Add a Trip'
  end

  scenario "search with name" do
    fill_in 's2id_autogen2', with: lastname # aka Search field
    expect(page).to have_no_selector('.selection_item', text: lastname)
 
  end

  scenario "search with email"

  xscenario "when has friends" do
    let(:friend) { create :hiker, :with_user }
    let(:other_trip) { create :trip }
    other_trip.hikers << [hiker, friend]

  end
end
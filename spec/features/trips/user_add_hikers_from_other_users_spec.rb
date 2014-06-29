require 'rails_helper'

feature 'User adds hiker from other users (static)', js: true do
  let!(:hiker)    { create :hiker, :with_user }
  let!(:other1)   { create :hiker, :with_user }
  let!(:other2)   { create :hiker, :with_user }

  let(:lastname)  { other1.name.split(' ').last }

  background do
    sign_in hiker
    click_on 'Add a Trip'
  end

  scenario "search with name" do
    click_on 'Add hiker'
   ele = page.find('.selection_item', text: other1.name)
    ele.click
    click_on 'Save', match: :first
    trip = Trip.last
    expect(trip.hikers).to match_array [hiker, other1] 

  end

  scenario "search with email"

end
require 'rails_helper'

feature 'User creates new trip' do
  let(:hiker) { create :hiker, :with_user }

  background do
    sign_in hiker: hiker
    click_on 'Create New Trip'
  end

  scenario "default values" do
    it 'me as hiker'
    it 'todays date'
  end

  it 'saves'
  it 'cancels'

end




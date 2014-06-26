require 'rails_helper'

feature 'User creates new trip', js: true do
  let(:hiker) { create :hiker, :with_user }

  background do
    sign_in hiker
    click_on 'Add a Trip'
  end

  context 'saves' do
    context 'default values when nothing entered' do
      background do
byebug
        click_on 'Save', match: :first
      end
      let(:trip) { Trip.last }

      it 'adds me as hiker' do
byebug
        expect(trip.hikers).to match_array [hiker]
      end
      it 'sets todays date' do
        expect(trip.date).to eql Date.today
      end
    end
    scenario 'filled out form'
  end

  it 'cancels'

end

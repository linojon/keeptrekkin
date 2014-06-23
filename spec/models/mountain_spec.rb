require 'rails_helper'

RSpec.describe Mountain, :type => :model do
  it { should have_and_belong_to_many(:trips) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }

  xit "unique index generates exception on duplicate trip"

  it "has many hikers through trips" do
    trip = create :trip
    mountain = create :mountain
    hiker1 = create :hiker
    hiker2 = create :hiker

    trip.mountains << mountain
    trip.hikers << hiker1
    trip.hikers << hiker2
    expect(mountain.hikers.all).to match_array([hiker1,hiker2])
  end
end

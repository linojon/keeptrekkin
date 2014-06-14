require 'rails_helper'

RSpec.describe Hiker, :type => :model do
  it { should have_and_belong_to_many(:trips) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }

  it "validations" do
    hiker = Hiker.new
    expect(hiker).to_not be_valid
    expect(hiker.errors[:name]).to include "can't be blank"
  end

  it "has many mountains through trips" do
    trip = create :trip
    mountain1 = create :mountain
    mountain2 = create :mountain
    hiker = create :hiker

    trip.mountains << mountain1
    trip.mountains << mountain2
    trip.hikers << hiker
    expect(hiker.mountains.all).to match_array([mountain1,mountain2])

    trip2 = create :trip
    trip2.hikers << hiker
    mountain3 = create :mountain
    trip2.mountains << mountain3
    expect(hiker.mountains.all).to match_array([mountain1,mountain2,mountain3])
  end

end

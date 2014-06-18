require 'rails_helper'

describe Hiker do
  it { should have_and_belong_to_many(:trips) }
  it { is_expected.to validate_presence_of :name }

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
 
  describe "update_attributes_only_if_blank" do
    let(:hiker) { build :hiker }
    let(:newattr) {{ name: 'foo bar', email: 'foo@bar.com' }}

    it "doesnt update existing attributes" do
      name = hiker.name
      email = hiker.email
      hiker.update_attributes_only_if_blank(newattr)
      expect(hiker.name).to eql name
      expect(hiker.email).to eql email
    end

    it "does update existing attributes" do
      hiker.name = nil
      hiker.email = ''
      hiker.update_attributes_only_if_blank(newattr)
      expect(hiker.name).to eql 'foo bar'
      expect(hiker.email).to eql 'foo@bar.com'
    end
  end
end

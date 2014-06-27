require 'rails_helper'

describe Hiker do
  it { should have_many(:trips).through(:hiker_trips) }
  it { is_expected.to validate_presence_of :name }
  xit { is_expected.to validate_presence_of :email }

  xit "unique index generates exception on duplicate trip"

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

  it "has many friends as hikers through trips" do
    trip = create :trip
    me = create :hiker
    hiker1 = create :hiker
    hiker2 = create :hiker
    trip.hikers << [me, hiker1, hiker2]
    expect(me.friends).to match_array [me, hiker1, hiker2]
    expect(me.just_friends).to match_array [hiker1, hiker2]
  end

  # it "scope not_authenticated" do
  #   hiker1 = create :hiker
  #   hiker2 = create :hiker
  #   create :user, hiker: hiker2
  #   expect(Hiker.not_authenticated.to_a).to eql [hiker1]
  # end

  describe "fuzzy" do
    let!(:named)   { create :hiker, name: 'Jonathan' }
    let!(:emailed) { create :hiker, email: 'linojon@gmail.com' }
    let!(:other)   { create :hiker }

    it "finds matches for name" do
      expect(Hiker.fuzzy(name:'jonathan')).to eql [named]
    end

    it "finds matches for email" do
      expect(Hiker.fuzzy(email:'iinojon@gmail.com')).to eql [emailed]
    end

    it "finds fuzzy matches" do
      expect(Hiker.fuzzy(name:'jon')).to eql [named]
      expect(Hiker.fuzzy(email:'linojon')).to eql [emailed]
    end

    it "can be chained to scopes" do
      # setup
      named2 = create( :hiker, name: 'Jonathan')
      named3 = create( :hiker, name: 'Jonathan')
      named4 = create( :hiker, name: 'Abcdefg')
      expect(Hiker.fuzzy(name:'Jonathan')).to eql [named,named2,named3]
      
      # scoped
      date = named.updated_at
      named3.update_attribute :updated_at, date
      named4.update_attribute :updated_at, date

      expect(Hiker.where(updated_at: date).fuzzy(name:'Jonathan')).to eql [named, named3]
    end
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

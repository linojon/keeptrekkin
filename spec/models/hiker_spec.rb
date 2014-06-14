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
end

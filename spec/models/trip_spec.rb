require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_many(:hikers).through(:hiker_trips) }
  it { should have_many(:mountains).through(:mountain_trips) }

  it "unique index generates exception on dupliate hiker"
  it "unique index generates exception on dupliate mountain"
end

require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_and_belong_to_many(:hikers) }
  it { should have_and_belong_to_many(:mountains) }

  it "unique index generates exception on dupliate hiker"
  it "unique index generates exception on dupliate mountain"
end

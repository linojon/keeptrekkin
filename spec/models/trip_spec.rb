require 'rails_helper'

RSpec.describe Trip, :type => :model do
  it { should have_and_belong_to_many(:hikers) }
  it { should have_and_belong_to_many(:mountains) }
end

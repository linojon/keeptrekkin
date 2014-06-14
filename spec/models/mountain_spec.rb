require 'rails_helper'

RSpec.describe Mountain, :type => :model do
  it { should have_and_belong_to_many(:trips) }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end

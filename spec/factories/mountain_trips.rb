# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mountain_trip, :class => 'MountainTrips' do
    mountain nil
    trip nil
  end
end

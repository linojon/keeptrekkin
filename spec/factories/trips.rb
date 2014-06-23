# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    date "2014-06-14"
    distance 1.5
    duration 1
    notes ""

    after(:create) do |trip, evaluator|
      trip.mountains << create(:mountain)
    end

    factory :trip_with_hiker do
      after(:create) do |trip, evaluator|
        trip.hikers << create( :hiker_with_user )
      end
    end

  end
end

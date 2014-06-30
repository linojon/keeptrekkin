# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    sequence(:title)    {|n| "Trip #{n}" }
    sequence(:date)     {|n| "2014-06-#{n}" }
    distance 1.5
    duration 1
    journal             { Faker::Lorem.sentence }

    trait :with_mountain do
      after(:create) do |trip, evaluator|
        trip.mountains << create(:mountain)
      end
    end

    trait :with_hiker do
      after(:create) do |trip, evaluator|
        trip.hikers << create( :hiker, :with_user )
      end
    end

  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hiker do
    name    { Faker::Name.name }
    email    { Faker::Internet.email }

    trait :with_user do
      after(:create) do |hiker, evaluator|
        hiker.user = create(:user)
        hiker.save
      end
    end
  end
end

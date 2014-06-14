# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mountain do
    name        { "#{Faker::Name.last_name} Mountain" }
    elevation   4000
  end
end

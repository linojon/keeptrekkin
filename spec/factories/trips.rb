# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trip do
    date "2014-06-14"
    distance 1.5
    duration 1
    notes ""
  end
end

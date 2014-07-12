# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    site_name "MyString"
    url "MyString"
    rating "MyString"
    mountain nil
  end
end

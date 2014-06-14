# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "MyString"
    uid "MyString"
    name "MyString"
    oauth_token "MyString"
    oauth_expires_at "2014-06-13 22:24:50"
  end
end

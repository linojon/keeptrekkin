# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid "12345"
    name "Joe Example"
    oauth_token "secrettoken"
    oauth_expires_at "2024-06-14 23:38:50"
  end
end

FactoryGirl.define do
  factory :account do
    email { Faker::Internet.email }
    password "ihanmitavaan"
    password_confirmation "ihanmitavaan"
    confirmed_at Date.today
  end
end
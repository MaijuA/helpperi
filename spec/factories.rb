FactoryGirl.define do
  factory :user do
    id "1"
    email { Faker::Internet.email }
    first_name "Matti"
    last_name "Mallikas"
    address "Mallitie 3"
    zip_code "02340"
    city "Espoo"
    phone_number "0501234567"
    personal_code "010191-123W"
    description "oon kiva"
    password "ihanmitavaan"
    password_confirmation "ihanmitavaan"
    confirmed_at Date.today
  end

  factory :post do
    user_id "1"
    title "Otsikko"
    description "kuvaus"
    price "10"
  end
end
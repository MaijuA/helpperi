FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    first_name "Matti"
    last_name "Mallikas"
    address "Mallitie 3"
    zip_code "02340"
    city "Espoo"
    phone_number "0501234567"
    personal_code "010191-123W"
    description "oon kiva"
    password "Ihanmitavaan1"
    password_confirmation "Ihanmitavaan1"
    confirmed_at Date.today
  end

  factory :post do
    title "Otsikko"
    description "kuvaus"
  end
end
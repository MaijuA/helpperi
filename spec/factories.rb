FactoryGirl.define do
  factory :user do
    id '1'
    email { Faker::Internet.email }
    first_name 'Matti'
    last_name 'Mallikas'
    address 'Mallitie 3'
    zip_code '02340'
    city 'Espoo'
    phone_number '0501234567'
    personal_code '010191-123W'
    description 'oon kiva'
    password 'ihanmitavaan'
    password_confirmation 'ihanmitavaan'
    deleted_at nil
    confirmed_at Date.today
  end

  factory :user2, class: User do
    id '1'
    email { Faker::Internet.email }
    first_name 'Matti'
    last_name 'Mallikas'
    address 'Mallitie 3'
    zip_code '02340'
    city 'Espoo'
    phone_number '0501234567'
    personal_code '010191-123W'
    description 'oon kiva'
    password 'Ihanmitavaan1'
    password_confirmation 'Ihanmitavaan1'
    deleted_at Date.today
    confirmed_at Date.today
  end

  factory :user3, class: User do
    id '2'
    email { Faker::Internet.email }
    first_name 'Matti'
    last_name 'Mallikas'
    address 'Mallitie 3'
    zip_code '02340'
    city 'Espoo'
    phone_number '0501234567'
    personal_code '010191-123W'
    description 'oon kiva'
    password 'Ihanmitavaan1'
    password_confirmation 'Ihanmitavaan1'
    deleted_at nil
    confirmed_at Date.today
  end

  factory :category do
    name 'Remontti'
  end

  factory :post do
    user_id '1'
    title 'Otsikko'
    description 'kuvaus'
    post_type 'Osto'
    ending_date DateTime.now + 1.month
    address 'Kumpulanmäki 1'
    zip_code 99999
    city 'Helsinki'
    radius 3
    price '10'
    deleted false
    association :category, factory: :category
  end

  factory :post2, class: Post do
    user_id '1'
    title 'Poistettu ilmoitus'
    description 'kuvaus'
    post_type 'Osto'
    ending_date DateTime.now + 1.month
    address 'Kumpulanmäki 1'
    zip_code 99999
    city 'Helsinki'
    radius 3
    price '10'
    deleted true
    association :category, factory: :category
  end

end
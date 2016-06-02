FactoryGirl.define do
  factory :user do
    id 1
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

    factory :deleted_user do
      id 3
      email { Faker::Internet.email }
      deleted_at Date.today
    end

    factory :user2 do
      id 2
    end
   end

  factory :category do
    id 1
    name 'Remontti'
  end

  factory :post do
    user_id 1
    title 'Koiran ulkoilutus'
    description 'kuvaus'
    post_type 'Osto'
    ending_date DateTime.now + 1.month
    address 'Kumpulanmäki 1'
    zip_code 99999
    city 'Helsinki'
    radius 3
    price '10'
    deleted false

    factory :post2 do
      id 2
    end

    factory :post_with_category do
      transient do
        category_count 1
      end
      after(:create) do |post, evaluator|
        create_list(:category, evaluator.category_count, posts: [post])
      end
    end

    factory :deleted_post_with_category do
      deleted true
      transient do
        category_count 1
      end
      after(:create) do |post, evaluator|
        create_list(:category, evaluator.category_count, posts: [post])
      end
    end

    factory :deleted_post do
      deleted true
    end
  end

  factory :post_category do
    post_id 1
    category_id 1

    factory :post_category2 do
      post_id 2
    end

    factory :post_category3 do
      post_id 3
    end
  end
end
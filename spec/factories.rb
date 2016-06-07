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

    factory :category2 do
      id 2
      name 'Siivous'
    end

    factory :category3 do
      id 3
      name 'Ruoka'
    end

    factory :category4 do
      id 4
      name 'Muu'
    end
  end

  factory :post do
    user_id 1
    title 'Koiran ulkoilutus'
    description 'kuvaus'
    post_type 'Osto'
    ending_date Date.today + 1.month
    address 'Kumpulanmäki 1'
    zip_code 99999
    city 'Helsinki'
    radius 3
    price '10'
    deleted false

    factory :post2 do
      id 2
      title 'Kaupassa käynti'
    end

    factory :post_with_category do
      id 3
      transient do
        category_count 1
      end
      after(:create) do |post, evaluator|
        create_list(:category, evaluator.category_count, posts: [post])
      end
    end

    factory :post_with_category2 do
      id 4
      title 'Kaupassa käynti'
      transient do
        category_count 1
      end
      after(:create) do |post, evaluator|
        create_list(:category2, evaluator.category_count, posts: [post])
      end
    end

    factory :post_with_category3 do
      id 5
      title 'Ruotsin opetusta'
      transient do
        category_count 1
      end
      after(:create) do |post, evaluator|
        create_list(:category3, evaluator.category_count, posts: [post])
      end
    end

    factory :deleted_post_with_category do
      id 6
      title 'Aidan maalaus'
      deleted true
      transient do
        category_count 1
      end
      after(:create) do |post, evaluator|
        create_list(:category4, evaluator.category_count, posts: [post])
      end
    end

    factory :deleted_post do
      id 7
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
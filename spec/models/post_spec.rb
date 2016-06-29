require 'rails_helper'

RSpec.describe Post, type: :model do

  it 'saves the post' do
    post = Post.create title: 'otsikko',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now + 1.month,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1

    expect(post.valid?).to be(true)
    expect(Post.count).to eq(1)
  end

  it 'doesn´t save the post if title is empty' do
    post = Post.create title: '',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now + 1.month,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1

    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if user id not present' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now + 1.month,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3

    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if price includes letters' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 'k',
                       post_type: 'Osto',
                       ending_date: DateTime.now + 1.month,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'saves the post in right type' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now + 1.month,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(true)
    expect(Post.buying.count).to eq(1)
  end

  it 'doesn´t save the post if ending_date is in the past' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: 2.days.ago,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if ending_date is too far in the future' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now + 6.months + 1.day,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if zip_code empty' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: '',
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if city empty' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: '',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if radius too big' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Myynti',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 300,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if ending_date is empty' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: '',
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if price is too high' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 501,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if price is negative' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: -1,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if type not in the list' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Ostot',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if title too short' do
    post = Post.create title: 'kis',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if title is too long' do
    post = Post.create title: Array.new(101){rand(36).to_s(36)}.join,
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'Kumpulanmäki 1',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if address is too long' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: Array.new(201){rand(36).to_s(36)}.join,
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if address is too short' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'PL',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if city contains numbers' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'PL33',
                       zip_code: 99999,
                       city: 'Helsinki1',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if zip code contains letters' do
    post = Post.create title: 'kissat',
                       description: 'kuvaus',
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'PL33',
                       zip_code: '999K9',
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

  it 'doesn´t save the post if description too long' do
    post = Post.create title: 'kissat',
                       description: Array.new(2001){rand(36).to_s(36)}.join,
                       price: 10,
                       post_type: 'Osto',
                       ending_date: DateTime.now,
                       address: 'PL33',
                       zip_code: 99999,
                       city: 'Helsinki',
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(0)
  end

end
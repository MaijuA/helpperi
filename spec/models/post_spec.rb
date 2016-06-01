require 'rails_helper'

RSpec.describe Post, type: :model do

  it "saves the post" do
    post_count = Post.count
    post = Post.create title: "otsikko",
                       description: "kuvaus",
                       price: 10,
                       post_type: "Osto",
                       ending_date: DateTime.now + 1.month,
                       address: "Kumpulanmäki 1",
                       zip_code: 99999,
                       city: "Helsinki",
                       radius: 3,
                       user_id: 1

    expect(post.valid?).to be(true)
    expect(Post.count).to eq(post_count + 1)
  end

  it "doesn´t save the post if title is empty" do
    post_count = Post.count
    post = Post.create title: "",
                       description: "kuvaus",
                       price: 10,
                       post_type: "Osto",
                       ending_date: DateTime.now + 1.month,
                       address: "Kumpulanmäki 1",
                       zip_code: 99999,
                       city: "Helsinki",
                       radius: 3,
                       user_id: 1

    expect(post.valid?).to be(false)
    expect(Post.count).to eq(post_count)
  end

  it "doesn´t save the post if user id not present" do
    post_count = Post.count
    post = Post.create title: "kissat",
                       description: "kuvaus",
                       price: 10,
                       post_type: "Osto",
                       ending_date: DateTime.now + 1.month,
                       address: "Kumpulanmäki 1",
                       zip_code: 99999,
                       city: "Helsinki",
                       radius: 3

    expect(post.valid?).to be(false)
    expect(Post.count).to eq(post_count)
  end

  it "doesn´t save the post if price includes letters" do
    post_count = Post.count
    post = Post.create title: "kissat",
                       description: "kuvaus",
                       price: "k",
                       post_type: "Osto",
                       ending_date: DateTime.now + 1.month,
                       address: "Kumpulanmäki 1",
                       zip_code: 99999,
                       city: "Helsinki",
                       radius: 3,
                       user_id: 1


    expect(post.valid?).to be(false)
    expect(Post.count).to eq(post_count)
  end

end
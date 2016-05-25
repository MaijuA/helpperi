require 'rails_helper'

RSpec.describe Post, type: :model do

  it "saves the post" do
    post_count = Post.count
    post = Post.create title: "otsikko",
                       description: "kuvaus",
                       price: 10,
                       user_id: 1

    expect(post.valid?).to be(true)
    expect(Post.count).to eq(post_count + 1)
  end

  it "doesn´t save the post if title is empty" do
    post_count = Post.count
    post = Post.create title: "",
                       description: "kuvaus",
                       price: 10,
                       user_id: 1

    expect(post.valid?).to be(false)
    expect(Post.count).to eq(post_count)
  end

  it "doesn´t save the post if user id not present" do
    post_count = Post.count
    post = Post.create title: "",
                       description: "kuvaus",
                       price: 10

    expect(post.valid?).to be(false)
    expect(Post.count).to eq(post_count)
  end

end
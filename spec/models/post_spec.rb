require 'rails_helper'

RSpec.describe Post, type: :model do

  it "saves the post" do
    post_count = Post.count
    post = Post.create title: "otsikko",
                       description: "kuvaus"

    expect(post.valid?).to be(true)
    expect(Post.count).to eq(post_count + 1)
  end

end


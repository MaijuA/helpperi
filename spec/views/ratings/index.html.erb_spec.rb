require 'rails_helper'

RSpec.describe "ratings/index", type: :view do
  before(:each) do
    assign(:ratings, [
      Rating.create!(),
      Rating.create!()
    ])
  end

  it "renders a list of ratings" do
    render
  end
end

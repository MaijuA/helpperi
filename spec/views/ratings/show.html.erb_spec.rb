require 'rails_helper'

RSpec.describe "ratings/show", type: :view do
  before(:each) do
    @rating = assign(:rating, Rating.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Users index page' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)
    FactoryGirl.create(:post_with_category)
    FactoryGirl.create(:post_with_category2)
    FactoryGirl.create(:deleted_post_with_category)
    post = FactoryGirl.create(:post_with_category3)
    post.update_attribute(:ending_date, Date.yesterday)
  end

  it 'should show users posts' do
    visit users_path

    expect(page).to have_content 'Koiran ulkoilutus'
    expect(page).to have_content 'Kaupassa käynti'
  end

  it 'shouldn´t show users deleted posts' do
    visit users_path

    expect(page).not_to have_content 'Aidan maalaus'
  end
end
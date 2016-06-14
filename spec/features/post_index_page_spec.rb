require 'rails_helper'

describe 'Posts page' do

  it 'should show posts' do
    FactoryGirl.create(:post_with_category)
    FactoryGirl.create(:post_with_category2)
    user = FactoryGirl.create(:user2)
    login_as(user)

    visit posts_path

    expect(page).to have_content 'Koiran ulkoilutus'
    expect(page).to have_content 'Kaupassa käynti'
  end

  it 'shouldn´t show expired posts' do
    post = FactoryGirl.create(:post_with_category3)
    post.update_attribute(:ending_date, Date.yesterday)

    visit posts_path

    expect(page).not_to have_content 'Ruotsin opetusta'
  end

  it 'shouldn´t show deleted posts' do
    FactoryGirl.create(:deleted_post_with_category)

    visit posts_path

    expect(page).not_to have_content 'Aidan maalaus'
  end
end
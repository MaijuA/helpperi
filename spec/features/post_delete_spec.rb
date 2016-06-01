require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Delete Post' do

  it 'soft-deletes post' do
    user = FactoryGirl.create(:user)
    login_as(user)
    post = FactoryGirl.create(:post)
    post_count = Post.count
    rack_test_session_wrapper = Capybara.current_session.driver
    rack_test_session_wrapper.submit :post, post_delete_post_path(post.id), nil


    expect(page).to have_content 'Ilmoitus on poistettu onnistuneesti.'
    expect(post_count).to eq(post_count)
  end

  it 'won´t delete post if not signed in' do
    visit root_path
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)
    rack_test_session_wrapper = Capybara.current_session.driver
    rack_test_session_wrapper.submit :post, post_delete_post_path(post.id), nil

    expect(page).to have_content 'Ilmoitusta ei voitu poistaa. Ole yhteydessä asiakaspalveluun.'
    expect(post.deleted).to be false
  end

  it 'won´t delete other users posts' do
    visit root_path
    user = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user3)
    login_as(user2)
    post = FactoryGirl.create(:post)
    rack_test_session_wrapper = Capybara.current_session.driver
    rack_test_session_wrapper.submit :post, post_delete_post_path(post.id), nil

    expect(page).to have_content 'Ilmoitusta ei voitu poistaa. Ole yhteydessä asiakaspalveluun.'
    expect(post.deleted).to be false
  end

  # it 'won´t show deleted post to users' do
  #   user = FactoryGirl.create(:user)
  #   login_as(user)
  #   post = FactoryGirl.create(:post2)
  #
  #   visit users_path
  #
  #   expect(page).not_to have_content 'Poistettu ilmoitus'
  # end


end
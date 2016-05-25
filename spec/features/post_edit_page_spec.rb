require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Edit post' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)

  end

  it 'edits title' do
    post = FactoryGirl.create(:post)

    visit edit_post_path(post)
    fill_in('post_title', with:'kauppareissu2')

    click_button('Muokkaa ilmoitusta')

    expect(page).to have_content 'kauppareissu2'
  end
end
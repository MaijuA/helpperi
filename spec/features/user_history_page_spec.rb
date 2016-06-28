require 'rails_helper'

describe 'Users history page' do
  let!(:user) { FactoryGirl.create :user }
  let!(:post) { FactoryGirl.create :post_with_category }

  it 'should show expired post' do
    login_as(user)
    post.update_attribute(:ending_date, Date.yesterday)

    visit user_history_path

    expect(page).to have_content 'Koiran ulkoilutus'
  end
end
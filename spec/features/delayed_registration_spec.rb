require 'rails_helper'

describe 'Delayed registration' do
  let!(:post_user) { FactoryGirl.create :user }
  let!(:user) { FactoryGirl.create :soft_user }
  let!(:post) { FactoryGirl.create :post_with_category }

  before :each do
    login_as(user)
  end

  it 'redirects to registration page if not fully registered and user tries to create new post' do
    visit users_path

    click_link 'Luo ilmoitus'

    expect(page).to have_content 'Viimeistele rekisteröitymisesi'
  end

  it 'if user not fully registered post page doesn´t have button to add user as candidate' do
    visit post_path(post)

    expect(page).not_to have_content 'Ilmoittaudu kiinnostuneeksi'
  end

end
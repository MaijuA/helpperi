require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'User sign in' do

  it 'user can sign in' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in('user_email', with: user.email)

    fill_in('user_password', with: user.password)

    click_button('Kirjaudu')

    expect(page).to have_content 'Sisäänkirjautuminen onnistui.'
  end

end
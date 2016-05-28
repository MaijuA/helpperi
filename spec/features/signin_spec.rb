require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'User sign in' do

  let(:user) { FactoryGirl.create(:user) }

  it 'user can sign in' do

    visit new_user_session_path

    fill_in('user_email', with: user.email)

    fill_in('user_password', with: user.password)

    click_button('Kirjaudu')

    expect(page).to have_content 'Sisäänkirjautuminen onnistui.'

  end

  it 'is lockable' do

    user.password += 'Not-My-Password'

    visit new_user_session_path

    10.times do

      fill_in('user_email', with: user.email)

      fill_in('user_password', with: user.password)

      click_button('Kirjaudu')

    end

    expect(page).to have_content 'Tunnuksesi on lukittu.'

  end

end
require 'rails_helper'

describe 'OAuth' do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:linkedin]
  end

  it 'should sign in with LinkedIn' do
    visit new_user_session_path

    click_link 'Kirjaudu LinkedIn-tunnuksilla'

    expect(page).to have_content 'Onnistuneesti valtuutettu käyttäen palvelua'
  end

  it 'should sign in with Google' do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    visit new_user_session_path

    click_link 'Kirjaudu Google-tunnuksilla'

    expect(page).to have_content 'Onnistuneesti valtuutettu käyttäen palvelua'
  end

  it 'should registrate user' do
    visit new_user_registration_path

    click_link 'Rekisteröidy LinkedIn-tunnuksilla'

    expect(page).to have_content 'Onnistuneesti valtuutettu käyttäen palvelua'
  end

  it 'redirects to registration edit page if registration not complete and user wants to create new post' do
    visit new_user_session_path

    click_link 'Kirjaudu LinkedIn-tunnuksilla'
    visit users_path
    click_link 'Luo ilmoitus'

    expect(page).to have_content 'Viimeistele rekisteröitymisesi'
  end

end
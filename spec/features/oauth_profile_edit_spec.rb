require 'rails_helper'

describe 'OAuth profile edit page' do
  before do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:linkedin]
  end

  it 'shouldn´t require current password' do
    visit new_user_session_path
    click_link 'Kirjaudu sisään LinkedIn-tunnuksilla'
    visit edit_user_registration_path

    fill_in('Henkilötunnus tai passin numero', with:'010191-123W')
    fill_in('Osoite', with:'Siilitie 4')
    fill_in('Postinumero', with:'00100')
    fill_in('Kaupunki', with:'Vantaa')
    fill_in('Puhelinnumero', with:'0501234567')

    click_button('Päivitä')

    expect(page).not_to have_content 'Nykyinen salasana ei voi olla sisällötön'
  end
end
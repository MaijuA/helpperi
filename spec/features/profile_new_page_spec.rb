
require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Sign in' do

  it 'registers new user' do
    visit new_user_registration_path
    fill_in('Sähköpostiosoite', with:Faker::Internet.email)
    fill_in('Etunimi', with:'Pekka')
    fill_in('Sukunimi', with:'Pekkanen')
    fill_in('Henkilötunnus tai passin numero', with:'010191-123W')
    fill_in('Puhelinnumero', with:'0501234567')
    fill_in('Osoite', with:'Mallitie 3')
    fill_in('Postinumero', with:'02340')
    fill_in('Kaupunki', with:'Espoo')
    fill_in('Salasana', with:'Ihanmitavaan1')
    fill_in('Salasana uudelleen', with:'Ihanmitavaan1')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Tervetuloa!'
  end
end
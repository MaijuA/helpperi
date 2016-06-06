
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

    expect(page).to have_content 'Rekisteröintisi onnistui'
  end

  it 'rejects email' do
    visit new_user_registration_path
    fill_in('Sähköpostiosoite', with: 'jarmo@pekkarinen')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Sähköpostiosoite ei ole mahdollinen'

    visit new_user_registration_path
    fill_in('Sähköpostiosoite', with: 'jarmo[at]pekkarinen.net')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Sähköpostiosoite ei ole mahdollinen'
  end

  it 'accepts first name' do
    visit new_user_registration_path
    fill_in('Etunimi', with: 'Ville-Veikko')

    click_button('Rekisteröidy')

    expect(page).to have_no_content 'Etunimi saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  end

  it 'accepts last name' do
    visit new_user_registration_path
    fill_in('Sukunimi', with: 'Von Hertzen')

    click_button('Rekisteröidy')

    expect(page).to have_no_content 'Sukunimi saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  end

  it 'rejects first name' do
    visit new_user_registration_path
    fill_in('Etunimi', with: 'V1ll3')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Etunimi saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  end

  it 'rejects last name' do
    visit new_user_registration_path
    fill_in('Etunimi', with: '-lol--@')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Sukunimi saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  end

  it 'rejects hetu' do
    visit new_user_registration_path
    fill_in('Henkilötunnus tai passin numero', with: '010191-123V')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Henkilötunnus tai passin numero on virheellinen'

    visit new_user_registration_path
    fill_in('Henkilötunnus tai passin numero', with: '010191+123V')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Henkilötunnus tai passin numero on virheellinen'

    visit new_user_registration_path
    fill_in('Henkilötunnus tai passin numero', with: '010106A235K')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Henkilötunnus tai passin numero - palveluun voivat rekisteröityä vain yli 15 vuotiaat'
  end

  it 'accepts passport number' do
    visit new_user_registration_path
    page.check('user_passport_number')
    fill_in('Henkilötunnus tai passin numero', with: 'M9989MFHFIEI2676')

    click_button('Rekisteröidy')

    expect(page).to have_no_content 'Henkilötunnus tai passin numero on virheellinen'
  end

  it 'rejects phone number' do
    visit new_user_registration_path
    fill_in('Puhelinnumero', with: '112')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Puhelinnumero ei ole mahdollinen'
  end

  it 'rejects address' do
    visit new_user_registration_path
    fill_in('Osoite', with: 'Å')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Osoite on liian lyhyt'
  end

  it 'rejects city' do
    visit new_user_registration_path
    fill_in('Kaupunki', with: '11710')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Kaupunki saa sisältää vain kirjaimia sekä väliliviivan tai välin nimien välissä'
  end

  it 'rejects password' do
    visit new_user_registration_path
    fill_in('Salasana', with: 'password')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Salasana on mustalistattu'

    visit new_user_registration_path
    fill_in('Salasana', with: 'lol12')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Salasana on liian lyhyt'

    visit new_user_registration_path
    fill_in('Salasana', with: 'Elokuva123')
    fill_in('Salasana uudelleen', with:'Elokuva12')

    click_button('Rekisteröidy')

    expect(page).to have_content 'Salasana uudelleen ei vastaa varmennusta'
  end

end
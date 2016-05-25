
require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Profile edit' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  it 'edits name' do
    visit edit_user_registration_path
    fill_in('Etunimi', with:'Pekka')
    fill_in('Sukunimi', with:'Pekkanen')
    fill_in('Nykyinen salasana', with:'Ihanmitavaan1')

    click_button('Päivitä')

    expect(page).to have_content 'Pekka Pekkanen'
  end

  it 'edits address' do
    visit edit_user_registration_path
    fill_in('Osoite', with:'Siilitie 4')
    fill_in('Postinumero', with:'00100')
    fill_in('Kaupunki', with:'Vantaa')
    fill_in('Nykyinen salasana', with:'Ihanmitavaan1')

    click_button('Päivitä')

    expect(page).to have_content 'Siilitie 4 00100 Vantaa'
  end

  it 'edits phone number' do
    visit edit_user_registration_path
    fill_in('Puhelinnumero', with:'0100001111')
    fill_in('Nykyinen salasana', with:'Ihanmitavaan1')

    click_button('Päivitä')

    expect(page).to have_content '0100001111'
  end

  it 'edits description' do
    visit edit_user_registration_path
    fill_in('Kuvaus', with:'olen luotettava')
    fill_in('Nykyinen salasana', with:'Ihanmitavaan1')

    click_button('Päivitä')

    expect(page).to have_content 'olen luotettava'
  end

  it 'does not edit password' do
    visit edit_user_registration_path
    fill_in('Salasana', with:'Pallo123')
    fill_in('Salasana uudelleen', with:'Pallo1234')
    fill_in('Nykyinen salasana', with:'Ihanmitavaan1')

    click_button('Päivitä')

    expect(page).to have_content 'Salasana uudelleen ei vastaa varmennusta'
  end


end
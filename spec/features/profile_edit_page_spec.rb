
require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Profile edit' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  it 'uploads and deletes image' do
    visit edit_user_registration_path
    page.attach_file('user_image', Rails.root + 'spec/fixtures/mikki.png')
    fill_in('Etunimi', with:'Pekka')
    fill_in('Sukunimi', with:'Pekkanen')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page.html).to include 'cloudinary.com'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'

    visit edit_user_registration_path
    check('user_remove_image')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page.html).not_to include 'cloudinary.com'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'
  end

  it 'rejects zip-file' do
    visit edit_user_registration_path
    page.attach_file('user_image', Rails.root + 'spec/fixtures/zip.zip')
    fill_in('Etunimi', with:'Pekka')
    fill_in('Sukunimi', with:'Pekkanen')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content 'Profiilikuva ei ole sallittua tiedostotyyppiä'
  end

  # it 'rejects too big file' do
  #   visit edit_user_registration_path
  #   page.attach_file('user_image', Rails.root + 'spec/fixtures/tetris.jpg')
  #   fill_in('Etunimi', with:'Pekka')
  #   fill_in('Sukunimi', with:'Pekkanen')
  #   fill_in('Nykyinen salasana', with:'ihanmitavaan')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'Profiilikuva ei ole sallittua tiedostotyyppiä'
  # end

  it 'edits name' do
    visit edit_user_registration_path
    fill_in('Etunimi', with:'Pekka')
    fill_in('Sukunimi', with:'Pekkanen')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content 'Pekka Pekkanen'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'
  end

  it 'edits address' do
    visit edit_user_registration_path
    fill_in('Osoite', with:'Siilitie 4')
    fill_in('Postinumero', with:'00100')
    fill_in('Kaupunki', with:'Vantaa')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content 'Siilitie 4 00100 Vantaa'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'
  end

  it 'edits phone number' do
    visit edit_user_registration_path
    fill_in('Puhelinnumero', with:'0100001111')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content '0100001111'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'
  end

  it 'edits description' do
    visit edit_user_registration_path
    fill_in('Kuvaus', with:'olen luotettava')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content 'olen luotettava'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'
  end

  it 'does not edit password if confirmation is wrong' do
    visit edit_user_registration_path
    fill_in('Salasana', with:'Pallo123')
    fill_in('Salasana uudelleen', with:'Pallo1234')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content 'Salasana uudelleen ei vastaa varmennusta'
  end

  it 'edits language' do
    visit edit_user_registration_path
    fill_in('Kielitaito', with:'suomi')
    fill_in('Nykyinen salasana', with:'ihanmitavaan')

    click_button('Päivitä')

    expect(page).to have_content 'suomi'
    expect(page).not_to have_content 'esti käyttäjän tallentamisen'
  end

end
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
  fill_in('etunimi', with:'Pekka')
  fill_in('sukunimi', with:'Pekkanen')
  fill_in('nykyinen salasana', with:'Ihanmitavaan1')

  click_button('Päivitä')

  expect(page).to have_content 'Pekka Pekkanen'
  end

it 'edits address' do
  visit edit_user_registration_path
  fill_in('katuosoite', with:'Siilitie 4')
  fill_in('postinumero', with:'00100')
  fill_in('kaupunki', with:'Vantaa')
  fill_in('nykyinen salasana', with:'Ihanmitavaan1')

  click_button('Päivitä')

  expect(page).to have_content 'Siilitie 4 00100 Vantaa'
end

it 'edits phone number' do
  visit edit_user_registration_path
  fill_in('puhelinnumero', with:'0100001111')
  fill_in('nykyinen salasana', with:'Ihanmitavaan1')

  click_button('Päivitä')

  expect(page).to have_content '0100001111'
end

it 'edits description' do
  visit edit_user_registration_path
  fill_in('kuvaus', with:'olen luotettava')
  fill_in('nykyinen salasana', with:'Ihanmitavaan1')

  click_button('Päivitä')

  expect(page).to have_content 'olen luotettava'
end

it 'does not edit password' do
  visit edit_user_registration_path
  fill_in('salasana', with:'Pallo123')
  fill_in('salasanan varmistus', with:'Pallo1234')
  fill_in('nykyinen salasana', with:'Ihanmitavaan1')

  click_button('Päivitä')

  expect(page).to have_content 'salasanan varmistus ei vastaa varmennusta'
end


end
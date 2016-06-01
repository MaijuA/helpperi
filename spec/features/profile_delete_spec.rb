require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Delete profile' do

  it 'soft-deletes profile' do
    user = FactoryGirl.create(:user)
    login_as(user)
    visit edit_user_registration_path

    click_button('Poista tilini')

    expect(page).to have_content 'Näkemiin! Tunnuksesi on nyt poistettu. Toivottavasti näemme sinut vielä uudelleen.'
  end

  it 'deleted user can´t sign in' do
    user = FactoryGirl.create(:user2)
    visit new_user_session_path
    fill_in('Sähköposti', with:user.email)
    fill_in('Salasana', with:'Ihanmitavaan1')
    click_button('Kirjaudu')

    expect(page).to have_content 'Olet poistanut tilisi. Jos haluat palauttaa tilisi, ota yhteyttä asiakaspalveluun.'
  end

  it 'soft-deletes users posts if user is deleted' do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post)
    login_as(user)
    visit edit_user_registration_path

    click_button('Poista tilini')

    visit posts_path

    expect(page).not_to have_content 'Koiran ulkoilutus'
  end

end
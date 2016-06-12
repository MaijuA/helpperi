require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'New post' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  it 'creates new post' do
    visit new_post_path
    choose('Haluan helpperiksi')
    fill_in('post_title', with:'kaupassa käynti')
    fill_in('post_price', with:12)
    fill_in('post_description', with:'kauppareissuun apua')
    fill_in('post_address', with:'Huuhaakatu 1')
    fill_in('post_zip_code', with:99999)
    fill_in('post_city', with:'Utsjoki')
    fill_in('post_radius', with:3)

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Ilmoitus luotu onnistuneesti'

  end

  it 'doesn´t add post if title empty' do
    visit new_post_path
    fill_in('post_title', with:'')

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Otsikko on liian lyhyt'
  end

  it 'doesn´t add post if price is empty' do
    visit new_post_path
    fill_in('post_price', with:'')

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Hinta ei voi olla sisällötön'
  end

  it 'doesn´t add post if price is too high' do
    visit new_post_path
    fill_in('post_price', with:501)

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Hinta täytyy olla pienempi kuin 500'
  end

  it 'doesn´t add post if description too long' do
    visit new_post_path
    fill_in('post_description', with:Array.new(2001){rand(36).to_s(36)}.join)

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Kuvaus on liian pitkä (saa olla enintään 2000 merkkiä)'
  end

  it 'doesn´t add post if zip code is empty' do
    visit new_post_path
    fill_in('post_zip_code', with:'')

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Postinumero ei ole mahdollinen'
  end


end
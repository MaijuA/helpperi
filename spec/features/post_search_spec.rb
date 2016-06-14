require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Search method' do

  before :each do
    user = FactoryGirl.create(:user2)
    login_as(user)
    post = FactoryGirl.create(:post)
    sleep 1.5
    post1 = FactoryGirl.create(:post_search)
    sleep 1.5
    post2 = FactoryGirl.create(:post_search2)
    visit root_path
  end

  it 'shows all posts' do
    click_button('Hae')

    expect(page).to have_content 'Kattejaa'
    expect(page).to have_content 'Hehehe'
    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'shows posts in right order' do

    expect(page.text).to match(/.*Hehehe.*Kattejaa.*Koiran\sulkoilutus.*/)
  end

  it 'shows right posts with title keyword with capslock' do
    fill_in('word', with:'KOIRA')
    click_button('Hae')

    expect(page).not_to have_content 'Kattejaa'
    expect(page).not_to have_content 'Hehehe'
    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with description keyword with capslock' do
    fill_in('word', with:'nyt kyllä')
    click_button('Hae')

    expect(page).not_to have_content 'Kattejaa'
    expect(page).to have_content 'Hehehe'
    expect(page).not_to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with city (with capslock)' do
    fill_in('city', with:'HelSInki  ')
    click_button('Hae')

    expect(page).not_to have_content 'Kattejaa'
    expect(page).not_to have_content 'Hehehe'
    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with zip code' do
    fill_in('zip_code', with:' 99999 ')
    click_button('Hae')

    expect(page).not_to have_content 'Kattejaa'
    expect(page).not_to have_content 'Hehehe'
    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with min price' do
    fill_in('min', with:'10')
    click_button('Hae')

    expect(page).not_to have_content 'Kattejaa'
    expect(page).not_to have_content 'Hehehe'
    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with max price' do
    fill_in('max', with:'9')
    click_button('Hae')

    expect(page).to have_content 'Kattejaa'
    expect(page).to have_content 'Hehehe'
    expect(page).not_to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with min and max price' do
    fill_in('max', with:'9')
    fill_in('min', with:'5')
    click_button('Hae')

    expect(page).to have_content 'Kattejaa'
    expect(page).not_to have_content 'Hehehe'
    expect(page).not_to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with type' do
    uncheck('post_type_selling_value')
    click_button('Hae')

    expect(page).to have_content 'Kattejaa'
    expect(page).not_to have_content 'Hehehe'
    expect(page).to have_content 'Koiran ulkoilutus'
  end

  it 'shows right posts with category' do
    post4 = FactoryGirl.create(:post_with_category3)
    post5 = FactoryGirl.create(:post_with_category2)
    visit root_path
    select "Siivous", :from => "category_ids[]"
    click_button('Hae')

    expect(page).not_to have_content 'Ruotsin opetusta'
    expect(page).to have_content 'Kaupassa käynti'
  end


  it 'shows right posts with type' do
    uncheck('post_type_buying_value')
    click_button('Hae')

    expect(page).not_to have_content 'Kattejaa'
    expect(page).to have_content 'Hehehe'
    expect(page).not_to have_content 'Koiran ulkoilutus'
  end

  it 'shows posts in min price order' do
    select "Pienin palkkio", :from => "table_id"
    click_button('Hae')

    expect(page.text).to match(/.*Hehehe.*Kattejaa.*Koiran\sulkoilutus.*/)
  end

  it 'shows posts in max price order' do
    select "Suurin palkkio", :from => "table_id"
    click_button('Hae')

    expect(page.text).to match(/.*Koiran\sulkoilutus.*Kattejaa.*Hehehe.*/)
  end

  it 'shows posts in ending soonest order' do
    select "Suurin palkkio", :from => "table_id"
    click_button('Hae')

    expect(page.text).to match(/.*Koiran\sulkoilutus.*Kattejaa.*Hehehe.*/)
  end


end
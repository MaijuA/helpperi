require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Edit post' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)

  end

  it 'edits title' do
    post = FactoryGirl.create(:post)

    visit edit_post_path(post)
    fill_in('post_title', with:'kauppareissu2')

    click_button('Muokkaa ilmoitusta')
    expect(page).to have_content 'kauppareissu2'
  end

  it 'edits description' do
    post = FactoryGirl.create(:post)

    visit edit_post_path(post)
    fill_in('post_description', with:'tarjoan apua')

    click_button('Muokkaa ilmoitusta')

    expect(page).to have_content 'tarjoan apua'
  end

  it 'edits price' do
    post = FactoryGirl.create(:post)

    visit edit_post_path(post)
    fill_in('post_price', with:'12')

    click_button('Muokkaa ilmoitusta')

    expect(page).to have_content '12'
  end

  it 'doesn´t edit if title empty' do
    post = FactoryGirl.create(:post)

    visit edit_post_path(post)
    fill_in('post_title', with:'')

    click_button('Muokkaa ilmoitusta')

    expect(page).to have_content 'Otsikko ei voi olla sisällötön'
  end
end
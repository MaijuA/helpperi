require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Edit post' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)
  end

  # it 'edits title' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_title', with:'kauppareissu2')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'kauppareissu2'
  # end
  #
  # it 'edits description' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_description', with:'tarjoan apua')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'tarjoan apua'
  # end
  #
  # it 'edits price' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_price', with:'12')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content '12'
  # end
  #
  # it 'edits address' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_address', with:'Tämätie 2')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'Tämätie 2'
  # end
  #
  # it 'edits zip code' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_zip_code', with:'02220')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content '02220'
  # end
  #
  # it 'edits city' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_city', with:'Kouvola')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'Kouvola'
  # end
  #
  # it 'edits radius' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_radius', with:'20')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content '20'
  # end
  #
  # it 'doesn´t edit if title empty' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #
  #   fill_in('post_title', with:'')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'Otsikko ei voi olla sisällötön'
  # end
  #
  # it 'doesn´t edit if price empty' do
  #   post = FactoryGirl.create(:post_with_category)
  #
  #   visit edit_post_path(post)
  #   fill_in('post_price', with:'')
  #
  #   click_button('Päivitä')
  #
  #   expect(page).to have_content 'Hinta ei voi olla sisällötön'
  # end

end
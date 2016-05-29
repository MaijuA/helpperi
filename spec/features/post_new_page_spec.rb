require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'New post' do
  before :each do
    user = FactoryGirl.create(:user)
    login_as(user)
  end



  it 'adds title' do
    visit new_post_path
    fill_in('post_title', with:'kauppareissu')

    click_button('Luo ilmoitus')

    expect(page).to have_content 'kauppareissu'

  end

  it 'adds description' do
    visit new_post_path
    fill_in('post_title', with:'kauppareissu')
    fill_in('post_description', with:'kauppareissuun apua')

    click_button('Luo ilmoitus')

    expect(page).to have_content 'kauppareissuun apua'

  end

  it 'adds price' do
    visit new_post_path
    fill_in('post_title', with:'kauppareissu')
    fill_in('post_price', with:'12')

    click_button('Luo ilmoitus')

    expect(page).to have_content '12'

  end

  it 'doesn´t add post if title empty' do
    visit new_post_path
    fill_in('post_title', with:'')
    fill_in('post_description', with:'kauppareissuun apua')
    fill_in('post_price', with:'12')

    click_button('Luo ilmoitus')

    expect(page).to have_content 'Otsikko ei voi olla sisällötön'

  end

end
require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Delete profile' do

  it 'soft-deletes profile' do
    user = FactoryGirl.create(:user)
    login_as(user)
    visit edit_user_registration_path

    click_button('Poista tilini')

    expect(page).to have_content 'Näkemiin!'
  end

  it 'deleted user can´t sign in' do
    user = FactoryGirl.create(:deleted_user)
    visit new_user_session_path
    fill_in('Sähköposti', with:user.email)
    fill_in('Salasana', with:'ihanmitavaan')
    click_button('Kirjaudu')

    expect(page).to have_content 'Olet poistanut tilisi. Jos haluat palauttaa tilisi, ota yhteyttä asiakaspalveluun.'
  end

   it 'soft-deletes users posts if user is deleted' do
     user = FactoryGirl.create(:user)
     post = FactoryGirl.create(:post_with_category)
     user.posts << post
     post_count = Post.active.count

     login_as(user)
     visit edit_user_registration_path

     click_button('Poista tilini')

     expect(Post.active.count).to eq(post_count - 1)
   end

end
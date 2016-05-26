require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

describe 'Delete profile' do
  let!(:user){FactoryGirl.create(:user)}

  it 'soft-deletes profile' do
    login_as(user)
    visit edit_user_registration_path

    click_button('Poista tilini')


    expect(page).to have_content 'Näkemiin! Tunnuksesi on nyt poistettu. Toivottavasti näemme sinut vielä uudelleen.'
    expect(user.deleted_at).not_to be_nil
  end
end
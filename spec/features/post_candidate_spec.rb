require 'rails_helper'

describe 'Post candidate' do
    let!(:user) { FactoryGirl.create :user }
    let!(:user3) { FactoryGirl.create :user3 }
    let!(:post) { FactoryGirl.create :post_with_category }

  it 'should add user as candidate' do
    login_as(user3)
    visit post_path(post)

    click_link 'Ilmoittaudu kiinnostuneeksi'

    expect(page).to have_content 'Sinut on lisätty kiinnostuneeksi.'
  end

  it 'should add user as candidate and show to user that he is candidate' do
    login_as(user3)
    visit post_path(post)

    click_link 'Ilmoittaudu kiinnostuneeksi'
    expect(page).to have_content 'Sinut on lisätty kiinnostuneeksi.'

    visit post_path(post)

    expect(page).to have_content 'Olet ilmoittaunut kiinnostuneeksi'
  end

  it 'should show candidates to post owner' do
    login_as(user3)
    visit post_path(post)

    click_link 'Ilmoittaudu kiinnostuneeksi'

    login_as(user)
    visit post_path(post)

    expect(page).to have_content 'Maija'
  end

  it 'post owner can deny user and denying shows to user' do
    login_as(user3)
    visit post_path(post)

    click_link 'Ilmoittaudu kiinnostuneeksi'
    login_as(user)

    visit post_path(post)

    click_link 'Hylkää'
    expect(page).to have_content 'Kiinnostunut on hylätty onnistuneesti.'
    expect(page).not_to have_content 'Maija'

    login_as(user3)

    visit post_path(post)

    expect(page).to have_content 'Ilmoittaja ei ole hyväksynyt sinua tällä kertaa.'
  end

  it 'post owner can accept candidate and it shows to user' do
    login_as(user3)
    visit post_path(post)

    click_link 'Ilmoittaudu kiinnostuneeksi'
    login_as(user)

    visit post_path(post)

    click_link 'Hyväksy'

    login_as(user3)

    visit post_path(post)

    expect(page).to have_content 'Olet sitoutunut tähän ilmoitukseen.'
  end
end
require 'rails_helper'

describe 'Post candidate' do
    let!(:user) { FactoryGirl.create :user }
    let!(:user3) { FactoryGirl.create :user3 }
    let!(:post) { FactoryGirl.create :post_with_category }

  it 'should add user as candidate' do
    login_as(user3)
    visit post_path(post)

    click_link 'Haluan helpperiksi'

    expect(page).to have_content 'Sinut on lisätty kiinnostuneeksi.'
  end

  it 'should add user as candidate and show to user that he is candidate' do
    login_as(user3)
    visit post_path(post)

    click_link 'Haluan helpperiksi'
    expect(page).to have_content 'Sinut on lisätty kiinnostuneeksi.'

    expect(page).to have_content 'Peru kiinnostuksesi'
    expect(post.helpers.ids).to include(user3.id)
  end

  it 'should show candidates to post owner' do
    login_as(user3)
    visit post_path(post)

    click_link 'Haluan helpperiksi'

    login_as(user)
    visit post_path(post)

    expect(page).to have_content 'Maija'
  end

  it 'post owner can deny user and denying shows to user' do
    login_as(user3)
    visit post_path(post)

    click_link 'Haluan helpperiksi'
    login_as(user)

    visit post_path(post)

    click_link 'remove'
    expect(page).to have_content 'Kiinnostunut on hylätty onnistuneesti.'
    expect(page).not_to have_content 'Maija'

    login_as(user3)

    visit post_path(post)

    expect(page).to have_content 'Ilmoittaja ei valinnut sinua tällä kertaa.'
  end

  it 'post owner can accept candidate and it shows to user' do
    login_as(user3)
    visit post_path(post)

    click_link 'Haluan helpperiksi'
    login_as(user)

    visit post_path(post)

    click_link 'ok'

    login_as(user3)

    visit post_path(post)

    expect(page).to have_content 'Olet sitoutunut tähän ilmoitukseen.'
  end

  it 'user can remove himself from candidates' do
    login_as(user3)
    visit post_path(post)

    click_link 'Haluan'
    expect(post.helpers.ids).to include(user3.id)
    expect(page).to have_content 'Peru kiinnostuksesi'

    click_link 'Peru kiinnostuksesi'

    expect(page).to have_content 'Haluan helpperiksi'
    expect(post.helpers.ids).not_to include(user3.id)
  end
end
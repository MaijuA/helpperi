require 'rails_helper'

describe 'User rating' do
  let!(:user1) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user2 }
  let!(:user3) { FactoryGirl.create :user3 }
  let!(:post) { FactoryGirl.create :post_with_category_and_performer }
  let!(:rating1) { FactoryGirl.create :rating }
  let!(:rating2) { FactoryGirl.create :rating2 }

  it 'should add new rating' do
    login_as(user1)
    visit users_path

    click_link 'Kuittaa suoritetuksi'

    find("#user_1_rating_score", visible: false).set(2)
    click_button 'Arvioi'

    expect(page).to have_content 'Arviointi onnistui'
    expect(Rating.count).to eq(3)
  end

  it 'shows average rating and rating count' do
    login_as(user2)
    visit user_path(user2)

    expect(page).to have_content '(2.0 / 2 arvostelua)'
  end

  it 'doesn´t add rating if stars not selected' do
    login_as(user1)
    visit users_path

    click_link 'Kuittaa suoritetuksi'

    click_button 'Arvioi'

    expect(page).to have_content 'Sinun täytyy valita tähtien määrä'
    expect(Rating.count).to eq(2)
  end

  it 'can´t rate if not post owner or performer' do
    login_as(user3)
    visit user_review_path(:post_id => 7)

    expect(page).not_to have_button('Arvioi')
  end
end
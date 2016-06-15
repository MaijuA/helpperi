require 'rails_helper'

describe 'Messages' do
  let!(:user) { FactoryGirl.create :user }
  let!(:user3) { FactoryGirl.create :user3 }
  let!(:user4) { FactoryGirl.create :user4 }

  it 'should send message' do
    c = Conversation.where(sender_id:user.id).count
    login_as(user)
    visit user_path(user3)

    click_link 'Lähetä viesti käyttäjälle'
    find('body').set('heipähei')

    click_button 'Lähetä viesti'

    expect(Conversation.where(sender_id:user.id).count).to eq(c+1)
  end

  it 'should redirect to root page if user not part of conversation' do
    login_as(user)
    visit user_path(user3)

    click_link 'Lähetä viesti käyttäjälle'
    find('body').set('heipähei')

    click_button 'Lähetä viesti'

    login_as(user4)

    visit conversation_messages_path(Conversation.where(sender_id:user.id).first)

    expect(page).to have_content('Muista valintani')
  end
end
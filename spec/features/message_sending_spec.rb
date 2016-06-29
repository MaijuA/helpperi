require 'rails_helper'

describe 'Messages' do
  let!(:user) { FactoryGirl.create :user }
  let!(:user3) { FactoryGirl.create :user3 }
  let!(:user4) { FactoryGirl.create :user4 }

  it 'should send message' do
    login_as(user)
    visit user_path(user3)

    click_link 'Lähetä viesti'
    fill_in('message_body', :with =>'heipähei')

    click_button 'Lähetä viesti'

    expect(Conversation.where(sender_id:user.id).count).to eq(1)
  end

  it 'should redirect to root page if user not part of conversation' do
    login_as(user)
    visit user_path(user3)

    click_link 'Lähetä viesti'
    fill_in('message_body', :with =>'heipähei')

    click_button 'Lähetä viesti'

    login_as(user4)

    visit conversation_messages_path(Conversation.where(sender_id:user.id).first)

    expect(page).to have_content('Hae')
  end

  it 'should send several messages and mark messages as read for user' do
    login_as(user)
    visit user_path(user4)

    click_link 'Lähetä viesti'

    (1..14).each do |i|
      fill_in('message_body', :with =>'heipähei')
      click_button 'Lähetä viesti'
    end

    expect(page).to have_content '10 uusinta'
    expect(Conversation.where(sender_id: user.id).where(recipient_id:user3.id).user_messages(user.id).unread_by(user).count).to eq(0)
  end

  it 'should not send empty message' do
    login_as(user)
    visit user_path(user4)

    click_link 'Lähetä viesti'

    fill_in('message_body', :with =>'')
    click_button 'Lähetä viesti'

    expect(page).to have_content 'Viestiä ei voitu lähettää'
  end

  it 'should show conversation in conversations/index' do
    login_as(user)
    visit user_path(user4)

    click_link 'Lähetä viesti'

    fill_in('message_body', :with =>'hei hei')
    click_button 'Lähetä viesti'

    visit conversations_path

    expect(page).to have_content 'Keijo'
  end
end


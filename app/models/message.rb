class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  #validates_presence_of :body, :conversation_id, :user_id

  def message_time
    # I18n.l created_at
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
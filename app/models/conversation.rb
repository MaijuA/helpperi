class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => [:recipient_id, :post_id]

  scope :between, -> (post_id,sender_id,recipient_id) do
    where("(conversations.post_id = ? AND conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.post_id = ? AND conversations.sender_id = ? AND conversations.recipient_id =?)", post_id, sender_id,recipient_id, post_id, recipient_id, sender_id)
  end

  scope :user_messages, -> (user_id) do
    Message.where(:conversation_id => Conversation.where("conversations.sender_id = ? OR conversations.recipient_id =?", user_id,user_id).ids).where.not(user_id:user_id)
  end

  scope :user_conversation, -> (user_id) do
    Conversation.where("conversations.sender_id = ? OR conversations.recipient_id =?", user_id,user_id)
  end

end
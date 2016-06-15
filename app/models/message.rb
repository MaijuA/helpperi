class Message < ActiveRecord::Base
  include PublicActivity::Model
  tracked

  acts_as_readable :on => :created_at

  belongs_to :conversation
  belongs_to :user

  scope :unread, -> do
    where('read = ?', false)
  end

  validates_presence_of :body, :conversation_id, :user_id

  def message_time
    I18n.l created_at, format: :short
  end
end
class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])

    if check_conversation_owner
      redirect_to root_path
    end

  end

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    @messages.unread_by(current_user).each do |m|
      m.mark_as_read! :for => current_user
    end

    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id, :read)
  end

  def check_conversation_owner
    Conversation.user_conversation(current_user).present?
  end
end
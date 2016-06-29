class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_conversation_creator, only: :create

  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    if Conversation.between(params[:post_id], params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:post_id], params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def check_conversation_creator
    redirect_to root_path unless params[:sender_id].to_i == current_user.id
  end

  def conversation_params
    params.permit(:sender_id, :recipient_id, :post_id)
  end
end
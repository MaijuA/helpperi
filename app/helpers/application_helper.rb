module ApplicationHelper
  def users_conversations_count
    Conversation.where(post_id:nil).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where.not(post_id:nil).where(post_id:(Candidate.where(denied:true).where(user_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where.not(post_id:nil).where.not(post_id:(Candidate.where(user_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
  end

  def users_post_conversations_count
    Conversation.where.not(post_id:nil).where(post_id:(Candidate.where(denied:false).where(user_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where.not(post_id:nil).where(post_id:(Post.where(doer_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where.not(post_id:nil).where(post_id:current_user.posts.ids).user_messages(current_user.id).unread_by(current_user).count
  end

  def distinct_conversation_count(post_id)
    Conversation.where(post_id:post_id).user_messages(current_user.id).unread_by(current_user).count
  end

  def distinct_conversation(current_id, helper_id, post_id)
    Conversation.where(sender_id:current_id).where(recipient_id:helper_id).where(post_id:post_id).first
  end

  def users_candidate_changes_count
    Candidate.where(user_id:current_user.id).where(denied:false).unread_by(current_user).count + Candidate.where(post_id:Post.where(user_id:current_user.id)).where(denied:false).unread_by(current_user).count
  end
end

module ApplicationHelper
  def users_conversations_count # counts all messages which aren´t related to own posts or interests or performed posts
    Conversation.where(post_id:nil).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where.not(post_id:(Post.where(doer_id:current_user.id))).where(post_id:(Candidate.where(denied:true).where(user_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where.not(post_id:(Post.where(user_id:current_user.id))).where.not(post_id:(Candidate.where(user_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
  end

  def posts_conversations_count # counts all users posts unread messages
    Conversation.where.not(post_id:nil).where(post_id:current_user.posts.ids).user_messages(current_user.id).unread_by(current_user).count
  end

  def candidate_conversations_count # counts all unread messages related to users interests
    Conversation.where(post_id:(Post.where(doer_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
    + Conversation.where(post_id:(Candidate.where(denied:false).where(user_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count
  end

  def post_conversation_count(post_id) # counts all conversations related to post
    Conversation.where(post_id:post_id).user_messages(current_user.id).unread_by(current_user).count
  end

  def distinct_conversation(helper_id, post_id) # gets conversation between post owner and candidate/performer
    Conversation.between(post_id:post_id, sender_id:current_user.id, recipient_id:helper_id).first
  end

  def conversation_user_count(helper_id, post_id) # counts unread messages between post owner and candidate/performer
    Conversation.between(post_id, current_user.id, helper_id).user_messages(current_user.id).unread_by(current_user).count
  end

  def post_candidate_changes_count # counts all changes in candidates in users own posts
    Candidate.where(post_id:Post.where(user_id:current_user.id)).where(denied:false).unread_by(current_user).count
  end

  def users_candidate_changes_count # counts changes in users interests
    Candidate.where(user_id:current_user.id).where(denied:true).where(post_id:(Post.where(doer_id:current_user.id))).unread_by(current_user).count
  end

  def users_candidate_changes(post_id) # counts changes in users interests
    Candidate.where(user_id:current_user.id).where(denied:true).where(post_id:post_id).unread_by(current_user).count
  end
end

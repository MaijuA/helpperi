module ApplicationHelper
  def users_index_message_count  # counts all unread messages in users/index
    Conversation.where(post_id:current_user.posts.valid.not_rated.ids).user_messages(current_user.id).unread_by(current_user).count +
        Conversation.where(post_id:(current_user.tasks.valid.not_rated.ids)).user_messages(current_user.id).unread_by(current_user).count +
        Conversation.where(post_id:(Post.where(doer_id:current_user.id).valid.not_rated.ids)).user_messages(current_user.id).unread_by(current_user).count
  end

  def users_mailbox_message_count # counts all messages which aren´t related to own posts or interests or performed posts
    Conversation.where(post_id:nil).user_messages(current_user.id).unread_by(current_user).count +
        Conversation.where(post_id:(Candidate.where(denied:true).where(user_id:current_user.id))).where.not(post_id:(Post.where(doer_id:current_user.id))).user_messages(current_user.id).unread_by(current_user).count +
        Conversation.where.not(post_id:(Post.where(user_id:current_user.id))).where.not(post_id:(Post.where(doer_id:current_user.id))).where.not(post_id:(current_user.tasks.ids)).user_messages(current_user.id).unread_by(current_user).count
  end

  def post_message_count(post_id) # counts all messages related to post
    Conversation.where(post_id:post_id).user_messages(current_user.id).unread_by(current_user).count
  end

  def conversation_user_count(helper_id, post_id) # counts unread messages between post owner and candidate/performer
    Conversation.between(post_id, current_user.id, helper_id).user_messages(current_user.id).unread_by(current_user).count
  end

  def users_index_candidate_count # counts all changes in candidates in users/index
    Candidate.where(post_id:current_user.posts.valid.not_rated.ids).where(denied:false).unread_by(current_user).count +
        Candidate.where(user_id:current_user.id).where(denied:true).where(post_id:(Post.where(doer_id:current_user.id).valid.not_rated)).unread_by(current_user).count
  end

  def post_candidate_changes(post_id) # counts candidate changes in users own post
    Candidate.where(post_id:post_id).where(denied:false).unread_by(current_user).count
  end
end
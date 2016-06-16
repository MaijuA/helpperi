class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
    @user_posts = @user.posts.active.valid
    if current_user == @user
      @user_expired_posts = @user.posts.active.expired
    end
    @rating = Rating.where(user_id: @user.id).first
    unless @rating
      @rating = Rating.create(post_id:100, user_id: @user.id, score: 0)
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    if current_user
      params[:page1] = 1 if params[:page1] == ''
      params[:page2] = 1 if params[:page2] == ''
      params[:page3] = 1 if params[:page3] == ''
      @user_posts = current_user.posts.active.valid.paginate(:page => params[:post_page], :per_page => 5)
      @user_accepted_posts = current_user.posts.valid.accepted.paginate(:page => params[:accepted_page], :per_page => 5)
      @user_expired_posts = current_user.posts.active.expired.paginate(:page => params[:expired_page], :per_page => 5)
    end
  end

  def interests
    if current_user
      params[:page1] = 1 if params[:page1] == ''
      params[:page2] = 1 if params[:page2] == ''
      params[:page3] = 1 if params[:page3] == ''
      @user_tasks = current_user.tasks.active.valid.paginate(:page => params[:tasks_page], :per_page => 5)
      @user_performer_posts = Post.where(doer_id:current_user.id).valid.paginate(:page => params[:performer_page], :per_page => 5)
      @user_performer_posts_expired = Post.where(doer_id:current_user.id).expired.paginate(:page => params[:performer_expired_page], :per_page => 5)
    end
  end
end
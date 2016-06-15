class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
    @user_posts = @user.posts.active.valid
    if current_user == @user
      @user_expired_posts = @user.posts.active.expired
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @user_activities = []
    PublicActivity::Activity.all.each do |p|
      if p.key == 'candidate.added' && current_user.posts.active.include?(Post.find(p.owner_id))
        @user_activities << p
      end
    end
    if current_user
      params[:page1] = 1 if params[:page1] == ''
      params[:page2] = 1 if params[:page2] == ''
      params[:page3] = 1 if params[:page3] == ''
      @user_posts = current_user.posts.active.valid.paginate(:page => params[:post_page], :per_page => 5)
      @user_accepted_posts = current_user.posts.valid.accepted.paginate(:page => params[:accepted_page], :per_page => 5)
      @user_expired_posts = current_user.posts.active.expired
      @user_tasks = current_user.tasks.paginate(:page => params[:tasks_page], :per_page => 5)
    end
  end

end
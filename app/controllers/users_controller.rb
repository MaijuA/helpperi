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
    if current_user
      @user_posts = current_user.posts.active.valid.paginate(:page => params[:page], :per_page => 15)
      @user_expired_posts = current_user.posts.active.expired
    end
  end




end
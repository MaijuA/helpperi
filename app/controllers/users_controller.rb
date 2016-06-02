class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  # GET /posts
  # GET /posts.json
  def index
    @user = User.find params[:id]
    @user_posts = @user.posts.active.valid
    if current_user
      @user_expired_posts = @user.posts.active.expired
    end
  end
end
class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.active
    if current_user
      @user_posts = current_user.posts.active
    end
  end
end
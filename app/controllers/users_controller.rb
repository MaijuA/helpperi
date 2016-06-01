class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  def index
    @user_posts
    if current_user
      @user_posts = current_user.posts
    end
  end

end
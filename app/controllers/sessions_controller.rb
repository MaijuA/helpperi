class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Tervetuloa takaisin!"
    else
      redirect_to :back, notice: "Käyttäjätunnus tai salasana väärin"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :signin
  end
end
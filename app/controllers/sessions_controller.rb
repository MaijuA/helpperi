class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by username: params[:username]
    if user.nil?
      redirect_to :back, notice: "Käyttäjää #{params[:username]} ei löydy!"
    else
      session[:user_id] = user.id if not user.nil?
      redirect_to user, notice: "Tervetuloa #{params[:username]}!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :signin
  end
end
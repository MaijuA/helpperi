
class AdminController < ApplicationController

  def list

    @users = User.all
  end

end
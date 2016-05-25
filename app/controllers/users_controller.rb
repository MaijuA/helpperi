class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def delete_user
    user = User.find(params[:user_id])
    if user.id == current_user.id
      user.update_attribute(:deleted, true)
    end
    if user.deleted
      reset_session
      redirect_to root_path, notice: 'Tilisi on poistettu onnistuneesti.'
    else
      redirect_to :back, notice: 'Tiliäsi ei voitu poistaa. Ole yhteydessä asiaskaspalveluun.'
    end
  end

end
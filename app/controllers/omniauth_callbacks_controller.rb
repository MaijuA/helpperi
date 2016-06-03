class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    auth_user("Google")
  end

  def facebook
    auth_user("Facebook")
  end

  def linkedin
    auth_user("LinkedIn")
  end


  def auth_user(provider)
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "#{provider}") if is_navigational_format?
    else
      redirect_to root_path, notice: 'Kirjautuminen/Rekisteröityminen ei onnistunut.'
    end
  end

  def failure
    redirect_to root_path
  end
end
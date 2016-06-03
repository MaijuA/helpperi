class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_oauth2
    auth_user("Google")
  end


  def auth_user(provider)
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "#{provider}") if is_navigational_format?
    else
      session["devise.provider_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
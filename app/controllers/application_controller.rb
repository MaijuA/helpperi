class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name]
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :personal_code, :phone_number, :address, :zip_code, :city, :description])
  end
end

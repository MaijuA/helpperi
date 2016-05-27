module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    parameters = [:first_name, :last_name, :personal_code, :passport_number, :phone_number, :address, :zip_code, :city, :description, :image, :remove_image, :image_cache]
    devise_parameter_sanitizer.permit(:sign_up, keys: parameters)
    devise_parameter_sanitizer.permit(:account_update, keys: parameters)
  end

end

DeviseController.send :include, DevisePermittedParameters
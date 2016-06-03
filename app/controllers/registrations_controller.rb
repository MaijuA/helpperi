class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    'posts#index' # Or :prefix_to_your_route
  end

  def destroy
    if !resource.posts.nil?
      resource.posts.each do |p|
        p.update_attribute(:deleted, true)
      end
    end
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end

end
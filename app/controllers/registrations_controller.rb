class RegistrationsController < Devise::RegistrationsController
  helper_method :save_my_previous_url

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

  def update_resource(resource, params)
    unless current_user.provider.nil?
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def save_my_previous_url

    if not(request.referer.to_s.include? 'edit') and not(request.referer.to_s.include? 'sign_in') and not(request.referer.to_s.include? 'sign_up')
      session[:my_previous_url] = request.referer
    end

  end

  protected

  def after_update_path_for(resource)
    session[:my_previous_url] || user_path(resource)
  end

  def after_sign_up_path_for(resource)
    session[:my_previous_url] || user_path(resource)
  end

end
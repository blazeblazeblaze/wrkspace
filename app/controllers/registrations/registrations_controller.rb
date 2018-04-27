class Registrations::RegistrationsController < Devise::RegistrationsController
  def new
    @signup_form = SignUpForm.new
  end

  def create
    @signup_form = SignUpForm.new(sign_up_params)

    if @signup_form.save
      self.resource = @signup_form.admin

      # :nocov: - Devise code
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
      # :nocov:
    else
      flash[:alert] = @signup_form.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def sign_up_params
    params.require(:sign_up_form).permit(
      :account_name, :email, :password, :password_confirmation)
  end
end

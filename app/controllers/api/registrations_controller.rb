# app/controllers/registrations_controller.rb
class Api::RegistrationsController < Devise::RegistrationsController
  @@a = :b
  skip_before_filter :verify_authenticity_token
  respond_to :json
  
  def create
    resource = User.new user_params

    if resource.save
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        return render json: { success: true, user: resource }
      else
        expire_session_data_after_sign_in!
        return render json: { success: true, user: resource, notice: "signed_up_but_#{resource.inactive_message}" }
      end
    else
      clean_up_passwords resource
      return render json: { success: false, errors: resource.errors.full_messages }
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    # prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
    # binding.pry
    result = params[:user] ? resource.update_without_password(user_params) : true

    if result
      return render json: { success: true, "#{resource_name}" => resource, message: "Successfully updated!" }
      # respond_with resource
    else
      clean_up_passwords resource
      return render json: { success: false, errors: resource.errors.full_messages }
    end
  end
 
  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end
 
  private

  def user_params
    fix_password_confirmation
    params.require(:user).permit! unless params[:user].blank?
  end

  def fix_password_confirmation
    params[:user][:password_confirmation] = "" unless params[:user][:password_confirmation]
  end

end
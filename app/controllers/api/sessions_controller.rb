class Api::SessionsController < Devise::SessionsController
	# prepend_before_filter :require_no_authentication, only: [ :new, :create ]
	# prepend_before_filter :allow_params_authentication!, only: :create
	# prepend_before_filter only: [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }
	
	skip_before_filter :verify_authenticity_token
	respond_to :json

	def create
		resource = warden.authenticate! auth_options

		render status: 200,
					 json: { success: true,
									 info: "Logged in",
									 user: current_user,
									 auth_token: current_user.authentication_token }
	end

	def destroy
		warden.authenticate! auth_options
		current_user.update_column(:authentication_token, nil)
		sign_out

		render status: 200, json: { success: true, info: "Logged out" }
	end

	def failure
    return render json: { success: false, error: "Invalid username or password" }
  end

	protected

	def auth_options
		{ scope: resource_name, recall: "#{controller_path}#failure" }
	end

end
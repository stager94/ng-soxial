class Api::UsersController < ApplicationController

	# before_filter :skip_trackable
	before_filter :authenticate_user!

	respond_to :json

	def show_current_user
		render status: 200, json: { success: true,
																info: "current_user",
																user: current_user,
																auth_token: current_user.authentication_token }	
	end

	def index
		render json: User.all, root: false
	end

	def show
		user = User.find_by id: params[:id]
	end

	private

	def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

end

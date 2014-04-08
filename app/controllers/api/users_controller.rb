class Api::UsersController < ApplicationController

	# before_filter :skip_trackable
	# before_filter :authenticate_user!

	respond_to :json

	def show_current_user
		authenticate_user!
		# binding.pry
		result = current_user ? true : false
		render status: 200, json: { success: result,
																info: "current_user",
																user: current_user.as_json(only: [:id, :email, :first_name, :last_name, :nickname, :about], methods: [:small_avatar, :simple_about]) }
	end

	def index
		# binding.pry
		render json: User.all, root: false
	end

	def show
		user = User.find_by id: params[:id]
		render json: user, root: false
	end

	private

	def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

end

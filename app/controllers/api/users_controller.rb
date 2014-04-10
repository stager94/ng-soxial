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
																user: UserSerializer.new(current_user) }
	end

	def index
		render json: User.all, root: false
	end

	def show
		user = User.find_by id: params[:id]
		render json: user, root: false
	end

	def favorite
		user = User.find_by id: params[:user_id]
		posts = user.favoriteline prepare_params
		
		render json: { 
			posts: posts.each.map{|p| PostSerializer.new(p, scope: current_user) }, 
			last_id: posts.last.item_id_in_line 
		}
	end

	private

	def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  def prepare_params
  	hash = Hash.new
  	hash[:limit] = 10
		unless params[:after].blank?
			hash[:last_shown_obj_id] = params[:after]
		end
		return hash
	end

end

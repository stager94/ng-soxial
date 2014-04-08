class Api::PostsController < ApplicationController
	def create
		post = Post.new post_params
		if post.save
			render json: post
		else
			render json: { success: false, errors: post.errors.full_messages }
		end
	end

	def index
		render json: Post.includes(:author).where(user_id: params[:user_id]), root: false
	end

	private

	def post_params
		params.require(:post).permit!
	end
end

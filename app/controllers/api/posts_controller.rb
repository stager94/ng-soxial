class Api::PostsController < ApplicationController
	def create
		post = Post.create post_params
		if post.valid?
			Image.where(id: params[:images_ids]).each do |image|
				image.update_attributes imageable_id: post.id, imageable_type: "Post"
			end

			render json: post
		else
			render json: { success: false, errors: post.errors.full_messages }
		end
	end

	def index
		posts = Post.includes(:author, :images).where(user_id: params[:user_id]).where("id < ?", min_id).limit Post::LIMIT

		render json: { 
			posts: posts.each.map{|p| PostSerializer.new(p, scope: current_user) }, 
			last_id: posts.last.id
		}
	end

	def favorite
		post = Post.find_by id: params[:id]
		current_user.favorite post

		render json: { success: true, favorite: current_user.favorite?(post) }
	end

	def unfavorite
		post = Post.find_by id: params[:id]
		
		current_user.unfavorite post

		render json: { success: true, favorite: current_user.favorite?(post) }
	end

	def destroy
		post = Post.find_by(id: params[:id])
		
		render json: { success: post.destroy }
	end

	private

	def post_params
		params.require(:post).permit!
	end

	def min_id
		params[:after] ||= ""
	end

end

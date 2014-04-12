class Api::AttachmentsController < ApplicationController
	def create
		image = Image.create params.require(:image).permit!
		
		render json: { 
				id: image.id,
				name: image.picture_file_name,
				size: image.picture_file_size,
				url: image.picture.url,
				thumbnailUrl: image.picture.url(:preview),
				deleteUrl: image.picture.url(:preview),
				deleteType: "DELETE"
		}	
	end

	def destroy
		image = Image.find_by id: params[:id]
		image.destroy

		render json: { success: true, image_id: image.id }
	end
end

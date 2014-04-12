class ImageSerializer < ActiveModel::Serializer
  attributes :id, :medium, :original, :width, :height

  def preview
  	object.picture.url :preview
  end

	def medium
  	object.picture.url :medium
  end

  def original
  	object.picture.url
  end

end
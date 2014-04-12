class Image < ActiveRecord::Base
	has_attached_file :picture, styles: { 
		preview: "100x100#",
		medium: "700x700>",
		original: "1000x1000>"
	}, convert_options: { 
		preview: "-strip -quality 50 -interlace Plane",
		medium: "-strip -quality 80 -interlace Plane",
		original: "-strip -quality 80 -interlace Plane",
	}

	belongs_to :imageable, polymorphic: true

  before_create :set_dimensions
  before_update :update_dimensions

	private

  def set_dimensions
    geo = Paperclip::Geometry.from_file picture.queued_for_write[:medium].path
    self.width = geo.width.to_i
    self.height = geo.height.to_i
  end

  def update_dimensions
    geo = Paperclip::Geometry.from_file picture.path(:medium)
    self.width = geo.width.to_i
    self.height = geo.height.to_i
  end

end

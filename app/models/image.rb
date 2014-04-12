class Image < ActiveRecord::Base
	has_attached_file :picture, styles: { 
		preview: "100x100#", 
		medium: "500x500#", 
		original: "1000x1000#" 
	}, convert_options: { 
		preview: "-strip -quality 50 -interlace Plane",
		medium: "-strip -quality 80 -interlace Plane",
		original: "-strip -quality 80 -interlace Plane",
	}

	belongs_to :imageable, polymorphic: true
end

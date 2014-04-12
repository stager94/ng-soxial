class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: "User"
  has_many :images, as: :imageable

  default_scope order("created_at desc")

  validates_presence_of :user_id, :author_id, :text

  acts_as_inkwell_post

  LIMIT = 10

  def favourite_for?
  	current_user.favourite? self
  end
end

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, class_name: "User"

  default_scope order("created_at desc")

  validates_presence_of :user_id, :author_id, :text
end

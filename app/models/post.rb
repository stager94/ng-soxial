class Post < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, :author_id, :text
end

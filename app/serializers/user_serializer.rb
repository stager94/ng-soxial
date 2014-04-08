class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :nickname, :about,
  					 :updated_at, :medium_avatar, :small_avatar, :full_name
  self.root = false

  def full_name
  	"#{object.first_name} #{object.last_name}"
  end

  def small_avatar
  	object.avatar.url :small
  end

  def medium_avatar
		object.avatar.url(:medium)
	end
end

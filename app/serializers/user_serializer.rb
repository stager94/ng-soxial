class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :nickname, :about,
  					 :updated_at, :medium_avatar, :full_name
  self.root = false

  def full_name
  	"#{object.first_name} #{object.last_name}"
  end
end

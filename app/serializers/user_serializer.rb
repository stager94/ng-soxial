class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :nickname, :about, :avatar, :updated_at, :medium_avatar
  self.root = false
end

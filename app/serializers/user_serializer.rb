class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  self.root = false
end

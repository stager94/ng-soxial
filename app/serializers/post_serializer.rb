class PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at_f, :is_favorite
  has_one :author
  self.root = false

  def created_at_f
  	object.created_at.strftime "%d.%m.%y %H:%M"
  end

  def is_favorite
  	scope.favorite? object
  end
end
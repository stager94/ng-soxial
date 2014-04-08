class PostSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at_f
  has_one :author
  self.root = false

  def created_at_f
  	object.created_at.strftime "%d.%m.%y %H:%M"
  end
end

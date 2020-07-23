class PostSerializer < ActiveModel::Serializer
  attributes :id, :name, :title, :alias, :text, :intro_text, :published, :created_at, :image
  belongs_to :image
end

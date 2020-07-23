class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :posts
  has_many :comments
  belongs_to :profile
end

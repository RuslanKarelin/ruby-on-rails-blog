class Comment < ActiveRecord::Base
  has_closure_tree
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable, dependent: :destroy
  belongs_to :user
end

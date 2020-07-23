class Category < ActiveRecord::Base
  include ModelShare

  has_closure_tree

  validates :name, :alias, presence: true
  validates :alias, uniqueness: true

  has_one :image, as: :imageable, dependent: :destroy
  has_many :widget_pages, as: :widgetable, dependent: :destroy
  has_and_belongs_to_many :posts
  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: proc {|attributes| attributes[:name].nil?}

  def split_posts_to_group
    if self.posts.present?
      posts = self.posts.includes(:categories, :category, :image, user: [profile: [:image]]).published.order(created_at: :desc).paginate(page: 1, per_page: 6)
      {
          first: posts.first,
          group1: posts.slice(1, 4),
          group2: posts.slice(5, posts.count),
      }
    end
  end
end

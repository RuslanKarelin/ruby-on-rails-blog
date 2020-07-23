class PostsRepository
  def self.get_popular
    Post.includes(hash_relations).published.limit(4)
  end

  def self.for_header_on_main
    posts = Post.published.includes(hash_relations).limit(3)
    {
        first: posts.first,
        group: posts.slice(1, 2)
    }
  end

  def self.recent_posts
    Post.includes(hash_relations).published.order(created_at: :desc).limit(4)
  end

  def self.posts_from_categories(categories, limit)
    Post.includes(:categories, :image).published.where(categories: {id: categories}).limit(limit).distinct
  end

  def self.get_posts(limit = 20)
    Post.includes(hash_relations).published.limit(limit)
  end

  def self.prev(post)
    Post.includes(:categories, :image)
        .published
        .where('"posts"."created_at" < :created_at', {created_at: post.created_at})
        .where(categories: {id: post.categories.pluck(:id)})
        .order(created_at: :desc).first
  end

  def self.next(post)
    Post.includes(:categories, :image)
        .published
        .where('"posts"."created_at" > :created_at', {created_at: post.created_at})
        .where(categories: {id: post.categories.pluck(:id)})
        .order(created_at: :asc).first
  end

  def self.related(post)
    Post.includes(hash_relations).published.where('"posts"."category_id" = :category_id AND "posts"."id" != :id', {category_id: post.category_id, id: post.id}).first(3)
  end

  def self.hash_relations
    [:category, :categories, :image, user: [profile: [:image]]]
  end
end
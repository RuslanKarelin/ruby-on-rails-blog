class CategoriesRepository
  def self.get_categories
    Category.includes(posts: [user: [profile: [:image]]]).all
  end
end
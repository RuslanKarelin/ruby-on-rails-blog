module ApplicationHelper
  def method_missing(meth)
    if meth.id2name =~ /^(.+?)_position$/
      render partial: 'shared/blocks/widgets_list',
             collection: WidgetsRepository.get_widgets_for_content($1, @model),
             as: :widget, cached: true
    end
  end

  def recent_posts
    PostsRepository.recent_posts
  end

  def posts_from_categories(categories, limit)
    PostsRepository.posts_from_categories(categories, limit)
  end

  def get_posts(limit)
    PostsRepository.get_posts(limit)
  end
end

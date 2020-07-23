module App
  def init
    @categories ||= CategoriesRepository.get_categories
    @popular_posts ||= PostsRepository.get_popular
    create_menus
  end

  def render_404
    @title = 404
    render page_path('404'), status: :not_found
    false
  end

  def check_404 (model)
    if model.present?
      data_prepare (model)
      model
    else
      render_404
    end
  end

  def data_prepare (model)
    @page_header_bg = nil
    @page_header = model.try(:show_page_header) || true
    @page_header_bg = model.image.name if @page_header && model.try(:image).present?
    @h1 = !model.try(:h1).blank? ? model.h1 : model.name
    @title = !model.try(:title).blank? ? model.title : model.name
    @intro_text = !model.try(:intro_text).blank? ? model.intro_text : nil
  end

  def get_pagination
    @page = params[:page].to_i + 1
    category = params[:category] if params[:category].present?
    user_id = params[:user] if params[:user].present?

    path_params = {page: @page}
    where = {}
    joins = nil

    if category
      path_params[:category] = category
      where[:categories] = {id: [category]}
      joins = :categories
    end

    if user_id
      path_params[:user] = user_id
      where[:user_id] = user_id
    end

    @link = pagination_path(path_params)
    @model = Post.joins(joins).where(where).order(created_at: :desc).paginate(page: @page, per_page: 6)

    render 'shared/get_pagination'
  end

  def create_menus
    @main_menu = Mmmenu.new(:request => request) do |l1|
      l1.add "Home", home_path
      l1.add "Lifestyle", category_path('lifestyle')
      l1.add "Fashion", category_path('fashion')
      l1.add "Technology", category_path('technology')
      l1.add "Health", category_path('health')
      l1.add "Travel", category_path('travel')
    end

    @aside_menu = Mmmenu.new(:request => request) do |l1|
      l1.add "Home", home_path
      l1.add "Categories", '#', html_options: {class: 'not_show'} do |l2|
        l2.add "Lifestyle", category_path('lifestyle')
        l2.add "Fashion", category_path('fashion')
        l2.add "Technology", category_path('technology')
        l2.add "Health", category_path('health')
        l2.add "Travel", category_path('travel')
      end
      l1.add "About Us", page_path('about-us')
      l1.add "Contacts", page_path('contacts')
    end

    @bottom_menu = Mmmenu.new(:request => request) do |l1|
      l1.add "Home", home_path
      l1.add "About Us", page_path('about-us')
      l1.add "Contacts", page_path('contacts')
    end
  end
end
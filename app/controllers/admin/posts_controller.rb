class Admin::PostsController < Admin::WidgetableController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Posts'
    @model = Post.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create post'
    @model = Post.new
    @model.build_image
  end

  def create
    @model = Post.new(model_params)
    if @model.save
      set_widgets
      redirect_to admin_posts_path, :notice => "Successfully created post."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit post'
    @model.build_image unless @model.image.present?
  end

  def update
    if @model.update_attributes(model_params.except("user_id"))
      delete_image?
      redirect_to admin_posts_path, :notice => "Successfully updated post."
    else
      render :edit
    end
  end

  def destroy
    @model = Post.find(params[:id])
    @model.destroy
    redirect_to admin_posts_path, :notice => "Successfully destroyed post."
  end

  private

  def get_model
    @model = Post.find(params[:id])
    @widget_ids = @model.widget_pages.pluck(:widget_id)
  end

  def model_params
    params.require(:post).permit(
        :name, :alias, :title, :h1, :published,
        :description, :intro_text, :text,
        :breadcrumb, :category_id, :all_tags, :user_id,
        category_ids: [],
        image_attributes: [:id, :name, :remove_name, :_destroy],
        widget_pages: [:widget_ids],
        widget_positions: []
    )
  end
end

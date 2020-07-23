class Admin::CategoriesController < Admin::WidgetableController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Categories'
    @model = Category.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create category'
    @model = Category.new
    @model.build_image
  end

  def create
    @model = Category.new(model_params)
    if @model.save
      set_widgets
      redirect_to admin_categories_path, :notice => "Successfully created category."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit category'
    @model.build_image unless @model.image.present?
  end

  def update
    if @model.update_attributes(model_params)
      delete_image?
      redirect_to admin_categories_path, :notice => "Successfully updated category."
    else
      render :edit
    end
  end

  def destroy
    @model = Category.find(params[:id])
    @model.destroy
    redirect_to admin_categories_path, :notice => "Successfully destroyed category."
  end

  private

  def get_model
    @model = Category.find(params[:id])
    @widget_ids = @model.widget_pages.pluck(:widget_id)
  end

  def model_params
    params.require(:category).permit(
        :name, :alias, :title, :h1,
        :description, :intro_text, :text,
        :breadcrumb, :parent_id, :top_text, :bottom_text,
        image_attributes: [:id, :name, :remove_name, :_destroy],
        widget_pages: [:widget_ids],
        widget_positions: []
    )
  end
end
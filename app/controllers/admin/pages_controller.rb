class Admin::PagesController < Admin::WidgetableController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Pages'
    @model = Page.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create page'
    @model = Page.new
    @model.build_image
  end

  def create
    @model = Page.new(model_params)
    if @model.save
      set_widgets
      redirect_to admin_pages_path, :notice => "Successfully created page."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit page'
    @model.build_image unless @model.image.present?
  end

  def update
    if @model.update_attributes(model_params)
      delete_image?
      redirect_to admin_pages_path, :notice => "Successfully updated page."
    else
      render :edit
    end
  end

  def destroy
    @model = Page.find(params[:id])
    @model.destroy
    redirect_to admin_pages_path, :notice => "Successfully destroyed page."
  end

  private

  def get_model
    @model = Page.find(params[:id])
    @widget_ids = @model.widget_pages.pluck(:widget_id)
  end

  def model_params
    params.require(:page).permit(
        :name, :alias, :title, :h1,
        :description, :intro_text, :text,
        :breadcrumb,
        image_attributes: [:id, :name, :remove_name, :_destroy],
        widget_pages: [:widget_ids],
        widget_positions: []
    )
  end
end
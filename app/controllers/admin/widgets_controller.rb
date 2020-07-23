class Admin::WidgetsController < Admin::AdminController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Widgets'
    @model = Widget.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create widget'
    @model = Widget.new
  end

  def create
    @model = Widget.new(model_params)
    if @model.save
      redirect_to admin_widgets_path, :notice => "Successfully created widget."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit widget'
  end

  def update
    if @model.update_attributes(model_params)
      redirect_to admin_widgets_path, :notice => "Successfully updated widget."
    else
      render :edit
    end
  end

  def destroy
    @model = Widget.find(params[:id])
    @model.destroy
    redirect_to admin_widgets_path, :notice => "Successfully destroyed widget."
  end

  private

  def get_model
    @model = Widget.find(params[:id])
  end

  def model_params
    params.require(:widget).permit(
        :name,
        :wname,
        :sort,
        :position_id
    )
  end
end

class Admin::WidgetPositionsController < Admin::AdminController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Widget positions'
    @model = WidgetsPosition.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create widget position'
    @model = WidgetsPosition.new
  end

  def create
    @model = WidgetsPosition.new(model_params)
    if @model.save
      redirect_to admin_widget_positions_path, :notice => "Successfully created widgets position."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit widget position'
  end

  def update
    if @model.update_attributes(model_params)
      redirect_to admin_widget_positions_path, :notice => "Successfully updated widgets position."
    else
      render :edit
    end
  end

  def destroy
    @model = WidgetsPosition.find(params[:id])
    @model.destroy
    redirect_to admin_widget_positions_path, :notice => "Successfully destroyed widgets position."
  end

  private

  def get_model
    @model = WidgetsPosition.find(params[:id])
  end

  def model_params
    params.require(:widgets_position).permit(
        :name
    )
  end
end
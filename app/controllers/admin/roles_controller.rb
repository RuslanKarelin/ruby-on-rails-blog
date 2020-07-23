class Admin::RolesController < Admin::AdminController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Roles'
    @model = Role.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create role'
    @model = Role.new
  end

  def create
    @model = Role.new(model_params)
    if @model.save
      redirect_to admin_roles_path, :notice => "Successfully created role."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit role'
  end

  def update
    if @model.update_attributes(model_params)
      redirect_to admin_roles_path, :notice => "Successfully updated role."
    else
      render :edit
    end
  end

  def destroy
    @model = Role.find(params[:id])
    @model.destroy
    redirect_to admin_roles_path, :notice => "Successfully destroyed role."
  end

  private

  def get_model
    @model = Role.find(params[:id])
  end

  def model_params
    params.require(:role).permit(
        :name
    )
  end
end

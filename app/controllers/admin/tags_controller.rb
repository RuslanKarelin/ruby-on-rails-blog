class Admin::TagsController < Admin::AdminController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Tags'
    @model = Tag.all.paginate(:page => params[:page])
  end

  def new
    @h1 = 'Create tag'
    @model = Tag.new
  end

  def create
    @model = Tag.new(model_params)
    if @model.save
      redirect_to admin_tags_path, :notice => "Successfully created tag."
    else
      render :new
    end
  end

  def edit
    @h1 = 'Edit tag'
  end

  def update
    if @model.update_attributes(model_params)
      redirect_to admin_tags_path, :notice => "Successfully updated tag."
    else
      render :edit
    end
  end

  def destroy
    @model = Tag.find(params[:id])
    @model.destroy
    redirect_to admin_tags_path, :notice => "Successfully destroyed tag."
  end

  private

  def get_model
    @model = Tag.find(params[:id])
  end

  def model_params
    params.require(:tag).permit(
        :name
    )
  end
end
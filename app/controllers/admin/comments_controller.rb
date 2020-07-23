class Admin::CommentsController < Admin::AdminController
  before_action :get_model, only: [:edit, :update, :show]

  def index
    @h1 = 'Comments'
    @model = Comment.all.paginate(:page => params[:page])
  end

  def edit
    @h1 = 'Edit comment'
  end

  def update
    if @model.update_attributes(model_params)
      redirect_to admin_comments_path, :notice => "Successfully updated comment."
    else
      render :edit
    end
  end

  def destroy
    @model = Comment.find(params[:id])
    @model.destroy
    redirect_to admin_comments_path, :notice => "Successfully destroyed comment."
  end

  private

  def get_model
    @model = Comment.find(params[:id])
  end

  def model_params
    params.require(:comment).permit(
        :body,
    )
  end
end
class Admin::IndexController < Admin::AdminController
  def index
    @h1 = 'Dashbord'
    @posts = Post.joins([:image]).all
    @categories = Category.all
    @pages = Page.all
    @comments = Comment.order(created_at: :desc).limit(5)
    @users = User.all
  end
end

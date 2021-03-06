class PostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create]

  def index
    @posts = Post.all.order(:user_id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'New post created!'
      redirect_to posts_path
    else
      flash.now[:danger] = "Title/body can't be empty!"
      render 'new'
    end
  end

  private

  def post_params
    params.require(:posts).permit(:title, :body)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'Please login'
    redirect_to login_path
  end
end

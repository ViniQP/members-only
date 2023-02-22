class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.author = current_user.username

    if @post.save
      redirect_to root_path
    else
      flash[:error] = "There was an error creating your post"
      render :new, status: :unprocessable_entity
    end
  end 

  private
    def require_login
      unless user_signed_in?
        flash[:error] = "You must be logged in to create a post"
        redirect_to new_user_session_path
      end
    end

    def post_params
      params.require(:post).permit(:title, :content, :author)
    end
end

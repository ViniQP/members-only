class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_member
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

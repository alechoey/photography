class PostsController < ApplicationController
  def index
    @posts = Post
    @posts = @posts.public unless user_signed_in?
    @posts = @posts.page(params[:page])
  end

  def show
    @post = Post.find_by_slug(params[:slug])
  end
end

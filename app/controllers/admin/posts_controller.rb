class Admin::PostsController < Admin::ApplicationController  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        flash[:success] = 'Post was successfully created'
        format.html { redirect_to posts_path}
      else
        @errors = @post.errors.full_messages
        format.html { render 'new' }
      end
    end
  end
  
  def edit
    @post = Post.find_by_slug!(params[:slug])
  end
  
  def update
    @post = Post.find_by_slug!(params[:slug])
    respond_to do |format|
      if @post.update_attributes(post_params)
        flash[:success] = 'Post was successfully updated'
        format.html { redirect_to post_path(@post) }
      else
        @errors = @post.errors.full_messages
        format.html { render 'edit' }
      end
    end
  end
  
  def destroy
    @post = Post.find_by_slug!(params[:slug])
    respond_to do |format|
      if @post.destroy
        flash[:success] = 'Post was successfully deleted'
        format.html {redirect_to posts_path }
      else
        flash[:error] = 'Post was unable to be successfully deleted'
        format.html { render 'posts/show' }
      end
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :slug, :body_before_break, :body_after_break, :public)
  end
end
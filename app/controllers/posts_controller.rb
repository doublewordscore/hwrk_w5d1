class PostsController < ApplicationController
  def show
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    post = Post.new(post_params)
    post.author_id = current_user.id
    post.sub_ids = params[:post][:sub_ids]
    if post.save
      redirect_to sub_url(params[:sub_id])
    else
      flash.now[:errors] = ["Post could not be created"]
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    post = Post.find(params[:id])
    post.sub_ids = params[:post][:sub_ids]
    if post.update_attributes(post_params)
      redirect_to subs_url
    else
      flash.now[:errors] = ["Post could not be edited!"]
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:notice] = ["Post was successfully destroyed!"]
      redirect_to sub_url(params[:sub_id])
    else
      flash[:errors] = ["Post was not deleted!"]
      redirect_to sub_url(params[:sub_id])
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, sub_ids: [])
  end
end

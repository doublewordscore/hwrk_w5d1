class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    comment = Comment.new(comment_params)
    comment.author_id = current_user.id
    comment.post_id = params[:post_id]
    if comment.save
      redirect_to post_url(comment.post_id)
    else
      flash.now[:error] = ["Comment could not be created!"]
      render :new
    end
  end

  def create_comment
    comment = Comment.new(comment_params)
    comment.author_id = current_user.id
    comment.parent_comment_id = params[:id]
    if comment.save
      redirect_to post_url(comment.post_id)
    else
      flash.now[:error] = ["Comment could not be created!"]
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update_attributes(comment_params)
      redirect_to post_url(comment.post_id)
    else
      flash.now[:errors] = ["Comment was not updated!"]
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

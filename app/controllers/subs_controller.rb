class SubsController < ApplicationController

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    subreddit = Sub.new(sub_params)
    subreddit.moderator_id = current_user.id
    if subreddit.save
      redirect_to subs_url
    else
      flash.now[:errors] = ["Sub wasn't created!"]
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    subreddit = Sub.find(params[:id])
    if subreddit.update_attributes(sub_params)
      redirect_to sub_url(subreddit.id)
    else
      flash.now[:errors] = ["Sub was not updated!"]
      render :edit
    end
  end

  def destroy
    subreddit = Sub.find(params[:id])
    if subreddit.destroy
      flash[:notice] = ["Subreddit was destroyed!"]
      redirect_to subs_url
    else
      flash[:errors] = ["Subreddit was not destroyed."]
      redirect_to sub_url(subreddit.id)
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, post_ids: [])
  end
end

class UsersController < ApplicationController
  def index
    render :index
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    user = User.new(user_params)
    # debugger
    if user.save
      log_in(user)
      redirect_to user_url(user.id)
    else
      flash.now[:errors] = ["Invalid username or password!"]
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      redirect_to user_url(user.id)
    else
      flash.now[:errors] = ["Couldn't update user profile!"]
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = ["User successfully deleted!"]
      redirect_to new_session_url
    else
      flash.now[:errors] = ["Couldn't destroy user!"]
      render :show
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_digest)
  end
end

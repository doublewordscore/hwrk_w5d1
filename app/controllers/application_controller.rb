class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in(user)
    if user
      session[:session_token] = user.reset_session_token!
      redirect_to user_url(user.id)
    else
      flash[:errors] = ["User not found! Please create account!"]
      redirect_to new_session_url
    end
  end



end

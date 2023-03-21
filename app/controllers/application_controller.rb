class ApplicationController < ActionController::Base
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = "You must log in first"
      redirect_to login_path
    end
  end
  
  helper_method :current_user, :logged_in?

end

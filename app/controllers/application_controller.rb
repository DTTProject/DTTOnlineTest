class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :signed_in?, :require_login

  protected

  def require_login
    unless signed_in?
      flash[:error] = 'You must sign in to see this page!'
      redirect_to login_path
    end
  end

  def skip_if_logged_in
    if signed_in?
      redirect_to root_path
    end
  end

  def signed_in?
    current_user
  end

  def current_user
    return @current_user if @current_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    end
  end
end

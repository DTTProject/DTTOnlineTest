class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def check_if_admin
    if user_signed_in?
      unless current_user.admin?
        flash[:warning] = t "page.admin.flash.admin_only"
        redirect_to root_path
      end
    else
      flash[:danger] = t "page.admin.flash.please_login"
      redirect_to root_path
    end
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:info] = "Please login!"
      redirect_to root_path
    end
  end
end

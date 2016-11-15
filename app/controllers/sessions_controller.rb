class SessionsController < ApplicationController
  before_action :skip_if_logged_in, except: [:destroy]
  
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = 'Login successfully.'
        redirect_to root_path
      else
        flash.now[:error] = 'Incorrect password.'
        redirect_to root_path
        #render 'new'
      end
    else
      flash.now[:error] = 'User not found.'
      redirect_to root_path
      #render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logout successfully.'
    redirect_to root_path
  end

  def callback
    if user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      flash[:success] = 'Login successfully.'
      redirect_to root_path
    else
      flash.now[:error] = 'Login error.'
      redirect_to root_path
    end
  end
end

class Admin::UsersController < ApplicationController
  layout "admin"
  # before_action :authenticate_user!
  before_action :load_user, only: :destroy

  def index
    @users =  User.includes([:questions, :tests, :comments]).with_deleted.page(params[:page])
      .per Settings.per_page
  end

  def log
  end

  def update
    User.restore params[:id]
    render json: {id: params[:id]}
  end

  def destroy
    # byebug
    @user.destroy
    render json: {id: params[:id]}
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
  end
end

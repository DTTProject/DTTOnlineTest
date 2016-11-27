class UsersController < ApplicationController
  # include LoadBestUsers
  before_action :authenticate_user!
  before_action :load_user

  def contributions
    @questions = @user.questions
      .page(params[:page]).per Settings.per_page
    render "questions/index"
  end

  def show
    @activities = Activity.order_desc.page(params[:page]).per Settings.per_page
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
  end
end

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
    # @activities = Activity.order_desc.page(params[:page]).per Settings.per_page
    @exams = Exam.where(user_id: current_user.id)
    @weeks_id =  current_user.tests.map(&:week_id).uniq
    @courses =  Course.get_courses @weeks_id
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
  end
end

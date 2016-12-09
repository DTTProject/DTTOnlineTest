class WeeksController < ApplicationController
  before_action :authenticate_user!
  before_action :load_week
  before_action :load_other_users, only: :exams
  def exams
    @exams = Exam.includes(:test).normal_exam(current_user).in_week(params[:id])
    .order_desc.page(params[:page]).per Settings.per_page
  end

  def challenges
    @tests =  current_user.tests.where(week_id: params[:id])
    @challenges = [[]]
    @tests.each do |test|
      if test.exams.size > 1
        @challenges << test.exams
      end
    end
  end

  private
  def load_week
    @week =  Week.find_by id: params[:id]
  end
  def load_other_users
    @others =  User.where.not(id: current_user.id).where(role: 0)
  end
end

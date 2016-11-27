class TestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tests =  Test.includes(:course).test_of_user(current_user).order_desc.
      page(params[:page]).per Settings.per_page
  end

  def new
    @test =  Test.new
  end

  def create
    @test = current_user.tests.build test_params
    @test.start_time = Time.now.to_i
    @test.end_time = Time.now.to_i
    respond_to do |format|
      if @test.save test_params
        format.html do
          flash[:success] = t "page.courses.detail.create.success"
          build_results @test, params[:test_complexity]
          redirect_to tests_path
        end
      else
        format.html do
        end
      end
    end
  end

  private
  def test_params
    params.require(:test).permit(
      :id, :user_id, :course_id,
      :status, :start_time,
      :endtime, :score,
      results_attributes: [:id, :question_id, :test_id, :answer_id]
    )
  end

  def build_results test, complexity
    if complexity == 'Random'
      test.create_results_for_random_test
    else
      test.create_results_with_complexity complexity
    end
  end
end

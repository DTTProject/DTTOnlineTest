class TestsController < ApplicationController
  include LoadBestUsersTest
  before_action :authenticate_user!
  before_action :load_test
  def index
    @courses =  Course.all
    @tests =  Test.includes(:course).test_of_user(current_user).order_desc.
      page(params[:page]).per Settings.per_page
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

  def show
    if @test.start? || @test.testing?
      caculate_time @test
    end
    if @test.start?
      @test.update_attributes  status: :testing
    end
    load_best_users_test @test.course
  end

  def update
    @test.end_time = Time.now.to_i
    if @test.update_attributes test_params
      if @test.finished?
        @test.score =  caculate_score @test
        @test.save
        flash[:success] = t "page.tests.do.finished_success"
        redirect_to test_path @test
      else
        flash[:success] = t "page.tests.do.save_success"
        redirect_to tests_path
      end
    else
      flash[:danger] = t "page.tests.do.save_fail"
      redirect_to :back
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

  def load_test
    @test = Test.find_by id: params[:id]
  end

  def caculate_time test
    @spend_time = test.end_time -  test.start_time
    @time = test.course.duration.to_i * Settings.MINUTE - @spend_time
    @hour = @time / 3600
    @minute = (@time % 3600) / 60
    @second = (@time % 3600) % 60
  end

  def caculate_score test
    (test.results.is_corrects.count).to_s + "/" + (test.course.question_numbers).to_s
  end
end

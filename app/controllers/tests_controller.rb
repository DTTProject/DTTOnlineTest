class TestsController < ApplicationController
  include LoadBestUsersTest
  before_action :authenticate_user!
  before_action :load_test

  def create
    @test = Test.new test_params
    respond_to do |format|
      if @test.save test_params
        format.html do
          flash[:success] = t "page.courses.detail.create.success"
          @exam = @test.create_exam current_user
          build_results @test, @exam, params[:test_complexity]
          redirect_to exams_week_path(@test.week)
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
      :id, :week_id
    )
  end

  def build_results test, exam, complexity
    if complexity == 'Random'
      test.create_results_for_random_test exam
    else
      test.create_results_with_complexity complexity, exam
    end
  end

  def load_test
    @test = Test.includes([:week, :notes]).find_by id: params[:id]
  end
end

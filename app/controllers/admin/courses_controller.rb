class Admin::CoursesController < ApplicationController
  layout "admin"
  before_action :set_course, except: :index
  before_action :check_if_admin

  def index
    @courses = Course.all
  end

  def show
  end

  def edit
  end

  def create
    @course = Course.new course_params
    respond_to do |format|
      if @course.save
        format.json do
          render json: @course, status: :created
        end
      else
        format.json {render json: @course.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update course_params
        format.json do
          render json: @course, status: :ok
        end
      else
        format.json do
          render json: @course.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_url, notice: t("courses.successfully_destroyed")
  end

  private
    def set_course
      @course = Course.find_by_id(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :description, :question_numbers, :duration, :image)
    end
end

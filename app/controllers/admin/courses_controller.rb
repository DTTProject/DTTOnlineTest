class Admin::CoursesController < ApplicationController
  layout "admin"
  before_action :set_course, except: :index

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/1
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: t("courses.successfully_created")
    else
      render :new
    end
  end

  # PATCH/PUT /courses/1
  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: t("courses.successfully_updated")
    else
      render :edit
    end
  end

  # DELETE /courses/1
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

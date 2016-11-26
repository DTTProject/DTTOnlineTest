class CoursesController < ApplicationController
  def show
    @course = Course.includes([:tests, :comments]).find_by id: params[:id]
  end
end

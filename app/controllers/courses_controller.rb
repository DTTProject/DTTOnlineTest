class CoursesController < ApplicationController
  include LoadBestUsersTest

  def show
    @course = Course.includes([:tests, :comments]).find_by id: params[:id]
    load_best_users_test @course
  end
end

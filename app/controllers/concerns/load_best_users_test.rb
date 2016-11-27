module LoadBestUsersTest
  extend ActiveSupport::Concern

  def load_best_users_test (course)
    @users =  User.send(:best_user_test, course.id)
  end
end

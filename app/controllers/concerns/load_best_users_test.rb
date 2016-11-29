module LoadBestUsersTest
  extend ActiveSupport::Concern

  def load_best_users_test (week)
    @users =  User.send(:best_user_test, week.id)
  end
end

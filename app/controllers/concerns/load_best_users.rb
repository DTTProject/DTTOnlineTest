module LoadBestUsers
  extend ActiveSupport::Concern
  included do
    before_action :load_best_users, :load_best_users_test
  end

  def load_best_users
    @users = User.send(:best_user_hash)
  end

  def load_best_users_test
    @users =  User.send(:best_user_test)
  end
end

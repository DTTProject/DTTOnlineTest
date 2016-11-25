module LoadBestUsers
  extend ActiveSupport::Concern
  included do
    before_action :load_best_users
  end

  def load_best_users
    @users = User.send(:best_user_hash)
  end
end

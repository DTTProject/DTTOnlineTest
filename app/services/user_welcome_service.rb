class UserWelcomeService
  def initialize user
    @user =  user
  end

  def welcome_user
    UserWelcomeMailer.send_message(@user).deliver
  end
end

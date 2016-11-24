class UserWelcomeMailer < ApplicationMailer
  default  from: Settings.default_email
  def send_message user
    @user =  user
    mail to: @user.email, subject: t("devise.email.welcome.title")
  end
end

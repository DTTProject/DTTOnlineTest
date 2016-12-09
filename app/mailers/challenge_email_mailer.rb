class ChallengeEmailMailer < ApplicationMailer
  default  from: Settings.default_email
  def challenge user, current, exam
    @user =  user
    @current =  current
    @exam =  exam
    mail to: @user.email, subject: "Challenge Test"
  end
end

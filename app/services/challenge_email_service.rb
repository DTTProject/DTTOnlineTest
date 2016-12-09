class ChallengeEmailService
  def initialize users, current, exam
    @users =  users
    @current  = current
    @exam =  exam
  end

  def welcome_user
    @users.each do |user|
      ChallengeEmailMailer.challenge(user, current, exam).deliver
    end
  end
end

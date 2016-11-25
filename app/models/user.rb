class User < ApplicationRecord
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: [:user, :admin]

  scope :best_user_hash, ->(){joins(:questions).where(users: {role: 0})
    .where.not(questions: {user_id: nil}).group('users.id')
    .order('COUNT(*) DESC').limit(5)}

  before_create :normal_user_role
  after_create :send_email

  def normal_user_role
    self.role =  Settings.role_user
  end

  def send_email
    UserWelcomeService.new(self).welcome_user
  end
end

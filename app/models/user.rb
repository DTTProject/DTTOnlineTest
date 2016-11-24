class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: [:admin, :user]

  before_create :normal_user_role
  after_create :send_email
  def normal_user_role
    self.role =  Settings.role_user
  end

  def send_email
    UserWelcomeService.new(self).welcome_user
  end
end

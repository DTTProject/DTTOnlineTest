class User < ApplicationRecord
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  enum role: [:user, :admin]

  before_create :normal_user_role
  after_create :send_email

  def normal_user_role
    self.role =  Settings.role_user
  end

  def send_email
    UserWelcomeService.new(self).welcome_user
  end
end

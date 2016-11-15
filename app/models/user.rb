class User < ApplicationRecord
  has_secure_password
  has_many :activities, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_insensitive: false }

  def self.from_omniauth(auth)
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    name = auth[:info][:name] || email
    password = auth[:uid]
    user = where(email: email).first_or_initialize
    user.name = name
    user.password = password
    user.save! && user
  end
end

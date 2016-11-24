class Course < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :description, presence: true
  validates :question_numbers, presence: true
  validates :duration, presence: true
end

class Course < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader
end

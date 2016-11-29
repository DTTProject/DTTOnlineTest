class Week < ApplicationRecord
  belongs_to :course
  has_many :questions
  has_many :tests, dependent: :destroy
  has_many :notes, dependent: :destroy
end

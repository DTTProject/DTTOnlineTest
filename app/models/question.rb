class Question < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :results, dependent: :destroy
  has_many :tests, through: :results
  has_many :answers, dependent: :destroy
end

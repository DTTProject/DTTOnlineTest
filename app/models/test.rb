class Test < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results
end

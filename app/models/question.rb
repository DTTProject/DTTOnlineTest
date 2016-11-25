class Question < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :results, dependent: :destroy
  has_many :tests, through: :results
  has_many :answers, dependent: :destroy

  validates :content, presence: true, length: {minimum: 10}

  enum status: [:accepted, :pending, :rejected]
  enum complexity: [:Difficult, :Normal, :Easy]

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :reject_answers


  def reject_answers (attributes)
    attributes['content'].blank?
  end
end

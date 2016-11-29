class Question < ApplicationRecord
  belongs_to :user
  belongs_to :course
  belongs_to :week
  has_many :results, dependent: :destroy
  has_many :tests, through: :results
  has_many :answers, dependent: :destroy

  validates :content, presence: true, length: {minimum: 10}

  enum status: [:accepted, :pending, :rejected]
  enum complexity: [:Difficult, :Normal, :Easy]

  scope :contribution, ->{joins(:user).where(users: {role: 0}).where.not(questions: {user_id: nil})}
  scope :not_contribution, ->{where(user_id: nil)}
  # scope :order_desc, ->{order('created_at DESC')}

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :reject_answers


  def reject_answers (attributes)
    attributes['content'].blank?
  end

end

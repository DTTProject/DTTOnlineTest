class Week < ApplicationRecord
  belongs_to :course
  has_many :questions
  has_many :tests, dependent: :destroy
  has_many :notes, dependent: :destroy

  def user_notes user_id
    self.notes.where(notes: {user_id: user_id})
  end
end

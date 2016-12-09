class Course < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :weeks, dependent: :destroy
  has_many :tests, through: :weeks
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :name, presence: true
  validates :description, presence: true
  validates :question_numbers, presence: true
  validates :duration, presence: true

  scope :get_courses, ->(weeks_id){joins(:weeks).where('weeks.id IN (?)', weeks_id)}
  accepts_nested_attributes_for :weeks, allow_destroy: true, reject_if: :reject_weeks
  def reject_weeks (attributes)
    attributes['content'].blank?
    attributes['description'].blank?
  end

end

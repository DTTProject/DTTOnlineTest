class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :test
  has_many :results, dependent: :destroy
  has_many :notes, dependent: :destroy
  enum status: [:start, :examing, :finished]
  enum test_type: [:normal, :challenge]
  accepts_nested_attributes_for :results,
  reject_if: lambda {|a| a[:question_id].blank?}, allow_destroy: true

  scope :normal_exam, ->(user){where(test_type: :normal).where(user_id: user.id)}
  scope :in_week, ->(week_id){joins(:test).where(tests: {week_id: week_id})}
  scope :in_week_normal, ->(week_id, current){joins(:test).where(exams: {test_type: :normal}).where(tests: {week_id: week_id}).where(exams: {user_id: current.id})}
  scope :in_week_challenge, ->(week_id){joins(:test).where(exams: {test_type: :challenge}).where(tests: {week_id: week_id})}
  def create_results questions
    questions.each{ |q| Result.create({question_id: q.id, exam_id: self.id}) }
  end

  def create_result_for_challenge current_user, test_id
    exam =  Exam.where(user_id: current_user.id).where(test_id: test_id).where(test_type: :normal).first
    question_ids = exam.results.map(&:question_id)
    question_ids.each do |question_id|
      Result.create({exam: self, question_id: question_id})
    end
  end
end

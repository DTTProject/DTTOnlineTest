class Test < ApplicationRecord
  include CreateActivity
  belongs_to :course
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  enum status: [:start, :testing, :finished]
  after_initialize :default_score
  after_create :create_activity_create_test
  accepts_nested_attributes_for :results,
    reject_if: lambda {|a| a[:question_id].blank?}, allow_destroy: true

  scope :test_of_user, ->(current_user){where(user_id: current_user.id)}
  def create_results_for_random_test
    # We create test real test with 50% normal questions, 30% easy questions,
    # and 20% difficult questions
    # Step 1: Get random question
    questions = self.course.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", 0).shuffle
      .take (course.question_numbers * 0.2).floor
    questions += self.course.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", 2).shuffle
      .take (course.question_numbers * 0.3).floor
    number_difficults = self.course.question_numbers -  questions.size
    questions += self.course.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", 2).shuffle
      .take number_difficults
    # Create result for each question
    create_results questions
  end

  def create_results_with_complexity complexity
    questions = self.course.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", complexity.to_i).shuffle
      .take course.question_numbers
    create_results questions
  end

  def create_results questions
    questions.each{ |q| Result.create({question_id: q.id, test_id: self.id}) }
  end

  def default_score
    self.score ||= '0'
  end

  def create_activity_create_test
    create_activity self.id, Settings.activity_type.create_exam, self.user.id
  end
end

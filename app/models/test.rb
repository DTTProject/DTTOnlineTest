class Test < ApplicationRecord
  include CreateActivity
  belongs_to :week
  has_many :exams, dependent: :destroy
  has_many :users, through: :exams
  # has_many :questions, through: :results
  # has_many :notes

  after_initialize :default_score
  # after_create :create_activity_create_test
  def create_results_for_random_test exam
    # We create test real test with 50% normal questions, 30% easy questions,
    # and 20% difficult questions
    # Step 1: Get random question
    questions = self.week.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", 0).shuffle
      .take (week.course.question_numbers * 0.2).floor
    questions += self.week.course.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", 2).shuffle
      .take (week.course.question_numbers * 0.3).floor
    number_difficults = self.week.course.question_numbers -  questions.size
    questions += self.week.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", 2).shuffle
      .take number_difficults
    # Create result for each question
    create_results questions, exam
  end

  def create_results_with_complexity complexity, exam
    questions = self.week.questions.where("questions.status =  ?", 0)
      .where("questions.complexity = ?", complexity.to_i).shuffle
      .take self.week.course.question_numbers
    create_results questions, exam
  end

  def create_exam current_user
    exam_params = {
      start_time: Time.now,
      end_time: Time.now,
      status: :start,
      test_type: :normal,
      test_id: self,
      user_id: current_user.id
    }
    self.exams.create exam_params
  end

  def create_results questions, exam
    questions.each{ |q| Result.create({question_id: q.id, exam_id: exam.id}) }
  end

  def default_score
    self.score ||= '0'
  end

  # def create_activity_create_test
  #   create_activity self.id, Settings.activity_type.create_exam, self.user.id
  # end
end

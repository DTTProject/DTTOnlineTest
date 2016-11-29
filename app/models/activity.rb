class Activity < ApplicationRecord
  belongs_to :user
  enum activity_type: [:create_exam, :finished_exam]

  def load_course
    test = Test.find_by id: self.target_id
    test.week.course
  end

  def load_user
    User.find_by id: self.user_id
  end
end

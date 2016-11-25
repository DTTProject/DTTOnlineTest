Fabricator :question do
  content {Faker::Lorem.sentence}
  status {Faker::Number.between(0, 2)}
  user_id :user_id
  course_id :course_id
  suggestion {Faker::Lorem.sentence}
  complexity {Faker::Number.between(0, 2)}
end

Fabricator :course do
  name :name
  description {Faker::Hipster.sentence}
  question_numbers {Faker::Number.between(5, 15)}
  duration {Faker::Number.between(10, 20)}
  image :image
end

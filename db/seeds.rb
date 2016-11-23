# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Course.create([
  {name: "Ruby On Rails", description: Faker::Lorem.sentence(3), question_numbers: Faker::Number.between(5,15), duration: Faker::Number.between(10,20), image: Faker::Avatar.image},
  {name: "NodeJs", description: Faker::Lorem.sentence(3), question_numbers: Faker::Number.between(5,15), duration: Faker::Number.between(10,20), image: Faker::Avatar.image },
  {name: "IOS", description: Faker::Lorem.sentence(3), question_numbers: Faker::Number.between(5,15), duration: Faker::Number.between(10,20), image: Faker::Avatar.image}
]);
Feedback.create([
  {name: "Brad", email: "a@a.com", content: Faker::Lorem.sentence(2), response: true},
  {name: "Kim", email: "b@b.com", content: Faker::Lorem.sentence(2), response: false},
  {name: "Luke", email: "c@c.com", content: Faker::Lorem.sentence(2), response: true}
]);

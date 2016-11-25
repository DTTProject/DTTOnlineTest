namespace :db do
  desc "Remaking data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Creating Admin"
    user = Fabricate :user, role: 1, email: "admin@gmail.com",
      name: "Admin"

    puts "Creating courses"
    course_names  = ['IOS',  'NodeJs', 'Ruby']
    course_names.each do |name|
      Fabricate :course, name: name,
        image: File.open(Dir["app/assets/images/#{name.downcase}.png"].sample)
    end

    puts "Creating question"
    Course.all.each do |course|
      course.question_numbers.size.times do
        Fabricate :question, course_id: course.id, status: 1
      end
    end

    puts "Creating users"
    user_hash = {
      "User 1": "user.1",
      "User 2": "user.2",
      "User 3": "user.3",
      "User 4": "user.4"
    }
    user_hash.each do |key, value|
      user = Fabricate :user, name: key, email: value+"@coderschool.com", role: 0
    end

    puts "Create contribute question for user"
    User.where.not(role: 1).each do |user|
      Faker::Number.between(3,6).times do
        Fabricate :question, user_id: user.id, status: 0, course_id: Course.ids.sample
      end
    end
    puts "Success remake data"
  end
end

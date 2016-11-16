json.extract! course, :id, :name, :description, :question_numbers, :duration, :image, :created_at, :updated_at
json.url course_url(course, format: :json)
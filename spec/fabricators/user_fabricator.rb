Fabricator :user do
  name :name
  email :email
  avatar {Faker::Avatar.image}
  role :role
  password "123456"
end

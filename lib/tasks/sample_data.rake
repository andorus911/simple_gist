namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    User.create!(name: "Admin User",
                 email: "admin@user.org",
                 password: "qwerty",
                 password_confirmation: "qwerty",
                 admin: true)

    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@user.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all.limit(6) # Only first six users
    50.times do
      title = Faker::Lorem.sentence
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.snippets.create!(title: title, content: content) }
    end
  end
end
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                 email: "example@railstutorial.org",
		 password: "foobar",
		 password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
	         email: email,
	         password: password,
                 password_confirmation: password)
    end
    users = User.all(limit: 6)
    50.times do
      name = Faker::Company.name
      billing_frequency = Faker::Lorem.words(2)
      users.each { |user| user.products.create!(name: name, billing_frequency: billing_frequency) }
    end
  end
end

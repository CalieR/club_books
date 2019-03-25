# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Club.destroy_all
User.destroy_all
Book.destroy_all

20.times do
    Book.create(title: Faker::Book.title, author: Faker::Book.author, description: Faker::Lorem.paragraph(4))
end

5.times do
    Club.create(name: Faker::GreekPhilosophers.name, description: Faker::Hipster.sentence(4))
end

10.times do
    User.create(name: Faker::Name.first_name)
end
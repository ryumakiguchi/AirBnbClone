# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(email: "user@gmail.com", password: "123456")
User.create!(email: "admin@gmail.com", password: "123456", admin: true)

Flat.create!(name: "Casita seed", description: "Casita muy bonita", address: "Toronto, Ontario, Canada", user_id: 1)
Flat.create!(name: "Edificio seed", description: "Edificio muy bonito", address: "Barcelona, Barcelona, Spain", user_id: 1)
Flat.create!(name: "Loft seed", description: "Loft muy bonito", address: "Arcadia, California, United States", user_id: 1)

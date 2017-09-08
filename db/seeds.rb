# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

start_at = DateTime.strptime('2001-02-03T10:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')
end_at = DateTime.strptime('2001-02-03T17:05:06+07:00', '%Y-%m-%dT%H:%M:%S%z')

Photo.destroy_all
Registration.destroy_all
Category.destroy_all
Event.destroy_all
Profile.destroy_all
User.destroy_all

kevin = User.create!(email: "kevin.chung@codaisseurup.com", password: "12345678")
smith = User.create!(email: "agent.smith@codaisseurup.com", password: "12345678")
jane = User.create!(email: "jane.doe@codaisseurup.com", password: "12345678")

leisure = Category.create!(name: "Leisure")
nature = Category.create!(name: "Nature")
racing = Category.create!(name: "Racing")
food = Category.create!(name: "Food")
sport = Category.create!(name: "Sport")

event1 = Event.create!(name: "Paintball Sunday", description: "Bring your guns and mostly importantly, your enthusiasm!", location: "Amsterdam", price: 20, capacity: 25, includes_food: true, includes_drinks: true, starts_at: start_at, ends_at: end_at, active: true, user: kevin, categories: [nature, sport])

event2 = Event.create!(name: "Amsterdam Pizza Festival", description: "Bring your Italian flavours!", location: "Amsterdam", price: 10, capacity: 35, includes_food: true, includes_drinks: true, starts_at: start_at, ends_at: end_at, active: true, user: jane, categories: [food, leisure])

# Photos
photo1 = Photo.create!(remote_image_url: "http://res.cloudinary.com/dgtx8b1vd/image/upload/v1504783695/pexels-photo-355988_siljb0.jpg", event: event1)
photo2 = Photo.create!(remote_image_url: "http://res.cloudinary.com/dgtx8b1vd/image/upload/v1504783695/pexels-photo-355988_siljb0.jpg", event: event1)
photo3 = Photo.create!(remote_image_url: "http://res.cloudinary.com/dgtx8b1vd/image/upload/v1504783695/pexels-photo-355988_siljb0.jpg", event: event1)

photo4 = Photo.create!(remote_image_url: "http://res.cloudinary.com/dgtx8b1vd/image/upload/v1504783695/pexels-photo-355988_siljb0.jpg", event: event2)
photo5 = Photo.create!(remote_image_url: "http://res.cloudinary.com/dgtx8b1vd/image/upload/v1504783695/pexels-photo-355988_siljb0.jpg", event: event2)
photo6 = Photo.create!(remote_image_url: "http://res.cloudinary.com/dgtx8b1vd/image/upload/v1504783695/pexels-photo-355988_siljb0.jpg", event: event2)

# Registrations
Registration.create!(user: kevin, event: event1, status: true, price: 12.5, guests_count: 3.0)
Registration.create!(user: jane, event: event2, status: true, price: 15.5, guests_count: 2.0)

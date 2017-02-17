# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = User.order(:created_at).take(2)
50.times do
  content = Faker::Lorem.sentence(1)
  second_content = Faker::Lorem.sentence(5)
  users.each { |user| user.events.create!(title: content, description: second_content) }
end

# Attending events
events = Event.all
user  = User.first
attended_events = events[1..40]
attended_events.each { |attended_event| user.attend_event(attended_event) }

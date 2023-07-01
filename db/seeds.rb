require "faker"

puts "Seeding Recipe data"
dish_names = [
  "Pasta Carbonara",
  "Chicken Tikka Masala",
  "Beef Stir-Fry",
  "Spaghetti Bolognese",
  "Grilled Salmon",
  "Vegetable Curry",
  "Beef Tacos",
  "Caesar Salad",
  "Mushroom Risotto",
  "Lemon Herb Chicken",
]

50.times do
  title = dish_names.sample
  instructions = Array.new(50 + rand(50..100)) { Faker::Lorem.word }.join(" ")
  minutes_to_complete = rand(20..300) # Random number between 20 and 300

  Recipe.create(title: title, instructions: instructions, minutes_to_complete: minutes_to_complete)
end

puts "Done seeding Recipe data"

puts "Seeding Users Data"
# Generate 50 users
50.times do
  username = Faker::Internet.unique.username(specifier: 5..10)
  password = Faker::Internet.password(min_length: 8)
  image_url = Faker::Avatar.image(slug: username, size: "300x300", format: "png")
  bio = Faker::Lorem.paragraph

  User.create(username: username, password: password, image_url: image_url, bio: bio)
end

puts "Done Seeding Users Data"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

family_guy = Video.create(title: "Family Guy", small_cover: "family_guy.jpg", large_cover: "monk_large.jpg", category_id: 1, description: "A great animated comedy.", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4")
futurama = Video.create(title: "Futurama", small_cover: "futurama.jpg", large_cover: "monk_large.jpg", category_id: 1, description: "An animated comedy set in space.", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4")
south_park = Video.create(title: "South Park", small_cover: "south_park.jpg", large_cover: "monk_large.jpg", category_id: 1, description: "A hilarious animated show about crazy kids.", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4")
monk = Video.create(title: "Monk", small_cover: "monk.jpg", large_cover: "monk_large.jpg", category_id: 2, description: "SF detective show.", video_url: "http://diikjwpmj92eg.cloudfront.net/mod0/teach/Mod0-1.introduction.mp4")

Category.create(name: "Comedy")
Category.create(name: "Drama")

boris = User.create(full_name: "Boris Smirnoff", password: "password", email: "boris@mail.com", admin: "1")

Review.create(user: boris, video: family_guy, rating: 5, content: "This is a great show.")
Review.create(user: boris, video: futurama, rating: 2, content: "This is a lousy show.")

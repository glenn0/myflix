# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

glenn = User.create(email: 'glenn@glenn.com', password: 'glenn', full_name: "Glenn O'Sullivan")
bob = User.create(email: 'bob@bob.com', password: 'bob', full_name: "Bob Barker")

comedy = Category.create(name: 'Comedy')
drama = Category.create(name: 'Drama')

fam_guy = comedy.videos.create(title: 'Family Guy: Season 1 Episode 1', description: "Lucky there's a family guy.", small_cover_url: '/tmp/family_guy.jpg', large_cover_url: '/tmp/family_guy_large.jpg')
monk = drama.videos.create(title: 'Monk: Season 1 Episode 1', description: "A quirky detective solves crime.", small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
futurama = comedy.videos.create(title: 'Futurama: Season 1 Episode 1', description: "Fry moves to the future to deliver pizza and more.", small_cover_url: '/tmp/futurama.jpg', large_cover_url: '/tmp/futurama_large.jpg')
southpark = comedy.videos.create(title: 'South Park: Season 1 Episode 1', description: "Come on down to South Park and meet some friends of mine.", small_cover_url: '/tmp/south_park.jpg', large_cover_url: '/tmp/south_park_large.jpg')

Review.create(user: glenn, video: monk, rating: 4, review_text: "Pretty good show, but there are better crime series out there.")
Review.create(user: bob, video: monk, rating: 2, review_text: "Worst show I've ever seen!")
Review.create(user: bob, video: monk, rating: 5, review_text: "Actually, it's not that bad.")
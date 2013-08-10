# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


comedy = Category.create(name: 'Comedy')
drama = Category.create(name: 'Drama')

comedy.videos.create(title: 'Family Guy', description: "Lucky there's a family guy.", small_cover_url: '/tmp/family_guy.jpg')
comedy.videos.create(title: 'Monk', description: "A quirky detective solves crime.", small_cover_url: '/tmp/monk.jpg', large_cover_url: '/tmp/monk_large.jpg')
drama.videos.create(title: 'Futurama', description: "Fry moves to the future to deliver pizza and more.", small_cover_url: '/tmp/futurama.jpg')
comedy.videos.create(title: 'South Park', description: "Come on down to South Park and meet some friends of mine.", small_cover_url: '/tmp/south_park.jpg')
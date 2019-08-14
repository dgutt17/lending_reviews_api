# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


business = Business.create(name: "first-midwest-bank")
review_1 = Review.new(title: "Review 1", content: "Hello Reviews! Its great to be here reviewing personal loans", total_rating: 3)
review_2 = Review.new(title: "Review 2", content: "Hello again! Its great to be here reviewing mortgage loans", total_rating: 5)
review_3 = Review.new(title: "Review 3", content: "Hello for the final time! Its great to be here reviewing student loans", total_rating: 1)

review_1.business = business
review_2.business = business
review_3.business = business

review_1.save!
review_2.save!
review_3.save!



# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

p 'Creating products...'
150.times do |_|
  Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    visible: [true, false].sample
  )
end
p 'Products created'

p 'Creating categories...'
50.times do |_|
  Category.create(
    name: Faker::Commerce.department
  )
end
p 'Categories created'

p 'Creating product-categories...'
Product.all.each do |product|
  product.categories << Category.all.sample(rand(1..5))
end
p 'Product categories created'

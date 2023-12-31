# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
require 'net/http'

50.times do
  u = User.create(name: Faker::Name.name, email: Faker::Internet.email,
                  bio: Faker::TvShows::TheExpanse.quote, password: 'pass123')

  puts "Creating user #{u.name}"
  puts 'Grabbing an avatar image'
  u.grab_avatar_image
end

u = User.all

u.each do |user|
  puts 'Setting up header image...'
  img = open('storage/japan-header.jpg')
  user.header_photo.attach(io: img, filename: 'japan-header.jpg')
  puts 'Header set up'
end

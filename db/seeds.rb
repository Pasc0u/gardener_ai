# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "open-uri"

Plant.destroy_all
User.destroy_all

puts "creating 3 users with plants"

pascaline = User.create!(
  email: "test@test.be",
  password: "test@test.be",
  username: "Pascaline",
  garden: "Mont des Arts"
)

pascaline.plants.create!(
  nickname: "Olive",
  species: "Olive Tree",
  image: URI.open("https://sachsenpalmen.de/cdn/shop/files/Oleaeuropea-Olivenbaum_Oelbaum.png?v=1746345407"),
  is_potted: true,
  age: "14",
  location: "sunny"
)
pascaline.plants.create!(
  nickname: "Vera",
  species: "Aloe Vera",
  image: URI.open("https://shop.plantura.garden/cdn/shop/files/blaetter-aloe-vera_720x.jpg?v=1705338508"),
  is_potted: true,
  location: "sunny"
)
pascaline.plants.create!(
  nickname: "Lilo",
  species: "Lotus",
  image: URI.open("https://www.bhg.com/thmb/KaC6_Zm_uK9wMVb_-TA-90zY7FQ=/4000x0/filters:no_upscale():strip_icc()/bhg-lotus-garden-8687628-15d0f58fd12c474188a97193a794127b.png"),
  is_potted: false,
  location: "sunny"
)

frank = User.create!(
  email: "test@test.hh",
  password: "test@test.hh",
  username: "Frank",
  garden: "Planten un Blomen"
)

frank.plants.create!(
  species: "Hydrangea",
  image: URI.open("https://www.servus.com/storage/article/artikel-garten-gartenwissen-optimaler-standort-richtige-pflege-hortensien-sv-mi.jpg?impolicy=article_short_header"),
  is_potted: false,
  location: "semi-shade"
)
frank.plants.create!(
  species: "Rhododendron",
  image: URI.open("https://www.garmundo.de/cdn/shop/files/roseumelegans1.webp?v=1718025412"),
  is_potted: false,
  location: "shade"
)
frank.plants.create!(
  nickname: "Iris",
  species: "Iris",
  image: URI.open("https://planttalk.colostate.edu/wp-content/uploads/2024/09/IMG_3918-scaled.jpeg"),
  is_potted: false,
  location: "sunny"
)
frank.plants.create!(
  nickname: "Frank",
  species: "Rose",
  image: URI.open("https://www.bhg.com/thmb/LpAFcR_n7TZJl7N9cLxU9k7h8YI=/4561x0/filters:no_upscale():strip_icc()/BHG-Tips-for-Growing-Roses-in-Pots-1551118932-bbd0eb1cb118471d907a61257973153e.jpg"),
  is_potted: true,
  location: "sunny"
)

lena = User.create!(
  email: "test@test.cgn",
  password: "test@test.cgn",
  username: "Lena",
  garden: "Flora"
)

lena.plants.create!(
  nickname: "Corny",
  species: "Ginster",
  image: URI.open("https://naturgartenshop.com/cdn/shop/files/Genista-pilosa-Vancouver-Gold-Sandginster-Vancouver-Gold.jpg?v=1726065004"),
  is_potted: true,
  age: "1",
  location: "shade"
)
lena.plants.create!(
  nickname: "Tusse",
  species: "Agapanthus",
  image: URI.open("https://www.myperfectgarden.eu/wp-content/themes/theme/inc/dwl-file.php?get_image=https://files.plytix.com/api/v1.1/rn/public_files/pim/assets/42/1a/77/5f/5f771a42758cab15f10cfaf8/images/94/fa/76/60/6076fa941610297ab5360688/agsdb002%20Agapanthus-Blue%20Thunder_Garden%25233.jpg/AGBLTHUN19_11.jpg?s=700x"),
  is_potted: true,
  age: "37",
  location: "sunny"
)
lena.plants.create!(
  nickname: "Olli",
  species: "Oleander",
  image: URI.open("https://www.heckenpflanzen-heijnen.de/public/data/image/article/1792/17869/small/rosanlorbeer-nerium-oleander-strauch-80-100-topf.jpg?v=aedd36e6ed37c600bfb91c045b75894c"),
  is_potted: true,
  age: "21",
  location: "sunny"
)
lena.plants.create!(
  nickname: "Horst",
  species: "Hydrangea",
  image: URI.open("https://bloomify.de/cdn/shop/files/bauernhortensie-b0138-blau-02-shop-3834.jpg?v=1745567889&width=3024"),
  is_potted: true,
  age: "7",
  location: "semi-shade"
)
lena.plants.create!(
  nickname: "Horti",
  species: "Hydrangea",
  image: URI.open("https://shop.plantura.garden/cdn/shop/files/samt-hortensie-macrophylla-bluete.jpg?v=1707411298"),
  is_potted: true,
  age: "1",
  location: "semi-shade"
)

puts "user & plant creation done"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
Shelter.destroy_all
mikes = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")
megs = Shelter.create(name: "Meg's Shelter", address: "150 Main Street", city: "Hershey", state: "PA", zip: "17033")
Pet.create(
  image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
  name: "Athena",
  description: "Butthead",
  age: "1",
  sex: "F",
  shelter: mikes)
Pet.create(
  image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
  name: "Odell",
  description: "good dog",
  age: "4",
  sex: "M",
  shelter: megs)

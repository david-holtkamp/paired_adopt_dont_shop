require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end
  describe "relationships"do
    it {should have_many :pets}
  end
  describe "methods" do
    it "pet_count" do
      dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      shelter_a = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      cdp = Shelter.create!(
        name: "Cool Dogs Palace",
        address: "89123 Cool St",
        city: "Cool City",
        state: "Coolorado",
        zip: "88888")
      Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: dog_city)
      Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: cdp)
      Pet.create(
        image: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook",
        description: "dread of the seven seas",
        age: "400 years old?",
        sex: "male",
        shelter: cdp)

      expect(dog_city.pet_count).to eq(1)
      expect(shelter_a.pet_count).to eq(0)
      expect(cdp.pet_count).to eq(2)
    end

    it "average_review_rating" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345"
      )

      img_review = Review.create!(
        title: "omg!!!",
        rating: 5,
        content: "pets super amazin!!",
        image: "https://cdn0.wideopenpets.com/wp-content/uploads/2016/04/valentines-8.jpg",
        shelter: shelter_1
      )
      no_img_review = Review.create!(
        title: "eh",
        rating: 3,
        content: "it's ok I guess",
        shelter: shelter_1
      )
      expect(shelter_1.average_review_rating).to eq(4)
    end

    it "applicant_count" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")

      pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: shelter_1)

      pet_2 = Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        status: "Pending",
        shelter: shelter_1)

      app_1 = Application.create({
        name: "David H",
        address: "1234 julian st.",
        city: "Denver",
        state: "CO",
        zip: "80211",
        phone_number: "303-465-1112",
        description: "I like dogs."
      })

      app_2 = Application.create({
        name: "David A",
        address: "1234 elm st.",
        city: "Denver",
        state: "CO",
        zip: "80212",
        phone_number: "303-465-4443",
        description: "I like dog."
      })

      app_1.pets << [pet_1, pet_2]
      app_2.pets << pet_1

      expect(shelter_1.applicant_count).to eq(2)
    end
  end
end

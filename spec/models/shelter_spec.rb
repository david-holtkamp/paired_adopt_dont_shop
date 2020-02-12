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
      expect(cdp.pet_count('Adoptable')).to eq(2)
      expect(cdp.pet_count('Pending')).to eq(0)
    end
  end
end

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe "validations" do
    it {should validate_presence_of :image}
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :status}
    it {should have_many :application_pets}
    it {should have_many(:applications).through(:application_pets)}
  end
  describe "relationships" do
    it {should belong_to :shelter}
  end
  describe "methods" do
    before :each do
      Pet.destroy_all
      Shelter.destroy_all
      @dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @a1 = Pet.create!(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: @dog_city)
      @a2 = Pet.create!(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: @dog_city)
      @p1 = Pet.create!(
        image: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook",
        description: "dread of the seven seas",
        age: "400 years old?",
        sex: "male",
        status: "Pending",
        shelter: @dog_city)
      @p2 = Pet.create!(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy Jr.",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        status: "Pending",
        shelter: @dog_city)
      @a3 = Pet.create!(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana Jr.",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: @dog_city)
      @p3 = Pet.create!(
        image: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook Jr.",
        description: "dread of the seven seas",
        age: "400 years old?",
        sex: "male",
        status: "Pending",
        shelter: @dog_city)
    end

    it "sort_by_status" do
      expect(Pet.sort_by_status).to eq([@a1, @a2, @a3, @p1, @p2, @p3])
    end

    it "adoptable" do
      expect(Pet.adoptable).to eq([@a1, @a2, @a3])
    end

    it "pending" do
      expect(Pet.pending).to eq([@p1, @p2, @p3])
    end
  end
end

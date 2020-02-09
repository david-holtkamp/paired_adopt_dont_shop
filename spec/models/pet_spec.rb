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

    it "pets_with_applications" do
      app_info = {name: "Joe", address: "12879 Maple St", city: "Denver", state: "CO", zip: "80211", phone_number: "202-131-5131", description: "I have snacks!"}
      visit "/pets/#{@p1.id}"
      click_link("Add to Favorites")
      visit "/pets/#{@p2.id}"
      click_link("Add to Favorites")
      visit "/pets/#{@p3.id}"
      click_link("Add to Favorites")

      visit '/favorites'

      click_link("Apply for Pets")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_css("#pet_id-#{@p1.id}")
      expect(page).to have_css("#pet_id-#{@p2.id}")
      expect(page).to have_css("#pet_id-#{@p3.id}")

      check "pet_id-#{@p1.id}"
      check "pet_id-#{@p2.id}"

      fill_in 'Name', with: app_info[:name]
      fill_in 'Address', with: app_info[:name]
      fill_in 'City', with: app_info[:city]
      fill_in 'State', with: app_info[:state]
      fill_in 'Zip', with: app_info[:zip]
      fill_in 'Phone number', with: app_info[:phone_number]
      fill_in "Description", with: app_info[:description]
      click_button "Submit Application"

      expect(Pet.applied_for).to eq([@p1, @p2])
    end
  end
end

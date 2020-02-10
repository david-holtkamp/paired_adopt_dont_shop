require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
    it {should validate_presence_of :phone_number}
    it {should validate_presence_of :description}
  end
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe "methods" do
    it "approved_for_pet" do
      dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: dog_city)
      app_1 = Application.create({
        name: "David H",
        address: "1234 julian st.",
        city: "Denver",
        state: "CO",
        zip: "80211",
        phone_number: "303-465-1112",
        description: "I like dogs."
        })

      app_1.pets << pet_1

      expect(app_1.approved_for_pet(pet_1)).to eq(false)

      visit "/applications/#{app_1.id}"
      within("#pet-#{pet_1.id}") { click_link('Approve Application')}

      expect(app_1.approved_for_pet(pet_1)).to eq(true)
    end
  end
end

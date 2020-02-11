require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the shelter show page" do
    it "I can delete a shelter from the database" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      shelter_2 = Shelter.create!(
        name: "delete me",
        address: "do",
        city: "it",
        state: "you",
        zip: "coward")

      visit "/shelters/#{shelter_2.id}"
      click_link("Delete Shelter")

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Name: #{shelter_1.name}")
      expect(page).to_not have_content(shelter_2.name)
    end
    it "I cannot delete a shelter with pending pets" do
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
      app_1 = Application.create!(
        name: "Guy",
        address: "23 Guy St",
        city: "Guy City",
        state: "CO",
        zip: "12345",
        phone_number: "303-210-2301",
        description: "Just a regular guy.")

      app_1.pets << pet_1

      visit "/applications/#{app_1.id}"
      within("#pet-#{pet_1.id}") { click_link('Approve Application')}

      visit "/shelters/#{dog_city.id}"

      click_link("Delete Shelter")
      expect(current_path).to eq("/shelters")
      expect(page).to have_css("#shelter-#{dog_city.id}")
      expect(page).to have_content("You cannot delete a shelter with approved pets.")

      visit "/shelters"

      within("#shelter-#{dog_city.id}") { click_link("Delete Shelter")}
      expect(current_path).to eq("/shelters")
      expect(page).to have_content("You cannot delete a shelter with approved pets.")

      visit "/applications/#{app_1.id}"
      click_link("Cancel Approval")

      visit "/shelters/#{dog_city.id}"

      click_link("Delete Shelter")

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_css("#shelter-#{dog_city.id}")
    end
  end

end

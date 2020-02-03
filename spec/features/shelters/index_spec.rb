require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the shelters index page" do
    before :each do
      @shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      @shelter_2 = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      visit "/shelters"
    end

    it "I can see names of all of the shelters" do
      within("#shelter-#{@shelter_1.id}") do
        expect(page).to have_content(@shelter_1.name)
      end
      within("#shelter-#{@shelter_2.id}") do
        expect(page).to have_content(@shelter_2.name)
      end
    end

    it "I can get to the edit page of a shelter" do
      within("#shelter-#{@shelter_1.id}") { click_link("Update Shelter") }

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
    end

    it "I can delete a shelter" do
      within("#shelter-#{@shelter_1.id}") { click_link("Delete Shelter") }

      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
    end

    it "I can click a shelter name to get to its show page" do
      within("#shelter-#{@shelter_1.id}") { click_link(@shelter_1.name) }

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    end
  end
end

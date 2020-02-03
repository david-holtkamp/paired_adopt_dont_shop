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
  end
end

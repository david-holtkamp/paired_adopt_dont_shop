require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the shelters index page" do
    it "I can get to the new shelter page, fill the form, and submit it" do
      Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      new_shelter_info = {
        name: "Cool Dogs Palace",
        address: "89123 Cool St",
        city: "Cool City",
        state: "Coolorado",
        zip: "88888"}

      visit "/shelters/"
      click_link "New Shelter"

      expect(current_path).to eq("/shelters/new")

      fill_in 'name', with: new_shelter_info[:name]
      fill_in 'address', with: new_shelter_info[:address]
      fill_in 'city', with: new_shelter_info[:city]
      fill_in 'state', with: new_shelter_info[:state]
      fill_in 'zip', with: new_shelter_info[:zip]

      click_button("Create Shelter")

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Cool Dogs Palace")
    end
  end
end

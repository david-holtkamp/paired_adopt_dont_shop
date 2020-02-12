require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the shelter show page" do
    it "I can get to the update page, fill in all fields of the update form, and submit the changes" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      updated_info = {
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414"}

      visit "/shelters/#{shelter_1.id}"
      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in 'name', with: updated_info[:name]
      fill_in 'address', with: updated_info[:address]
      fill_in 'city', with: updated_info[:city]
      fill_in 'state', with: updated_info[:state]
      fill_in 'zip', with: updated_info[:zip]

      click_button("Update Shelter")

      expect(current_path).to eq("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Name: #{updated_info[:name]}")
      expect(page).to have_content("Address: #{updated_info[:address]}")
      expect(page).to have_content("City: #{updated_info[:city]}")
      expect(page).to have_content("State: #{updated_info[:state]}")
      expect(page).to have_content("Zip: #{updated_info[:zip]}")

      expect(page).to_not have_content("Name: #{shelter_1.name}")
      expect(page).to_not have_content("Address: #{shelter_1.address}")
      expect(page).to_not have_content("City: #{shelter_1.city}")
      expect(page).to_not have_content("State: #{shelter_1.state}")
      expect(page).to_not have_content("Zip: #{shelter_1.zip}")
    end
    it "I see a flash message error indicating which fields are not complete" do
      shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")

      updated_info = {
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414"}

      visit "/shelters/#{shelter_1.id}"
      click_link "Update Shelter"

      fill_in 'name', with: updated_info[:name]
      fill_in 'address', with: ""
      fill_in 'city', with: updated_info[:city]
      fill_in 'state', with: updated_info[:state]
      fill_in 'zip', with: updated_info[:zip]
      click_button("Update Shelter")

      expect(page).to have_content("Address can't be blank")

      fill_in 'name', with: ""
      fill_in 'address', with: updated_info[:address]
      fill_in 'city', with: updated_info[:city]
      fill_in 'state', with: updated_info[:state]
      fill_in 'zip', with: updated_info[:zip]

      click_button("Update Shelter")

      expect(page).to have_content("Name can't be blank")

      fill_in 'name', with: updated_info[:name]
      fill_in 'address', with: updated_info[:address]
      fill_in 'city', with: updated_info[:city]
      fill_in 'state', with: ""
      fill_in 'zip', with: updated_info[:zip]

      click_button("Update Shelter")

      expect(page).to have_content("State can't be blank")
    end
  end
end

require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the new application page" do
    before :each do
      Pet.destroy_all
      Shelter.destroy_all
      @dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: @dog_city)
      @pet_2 = Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: @dog_city)
      @pet_3 = Pet.create!(
        image: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook",
        description: "dread of the seven seas",
        age: "400 years old?",
        sex: "male",
        shelter: @dog_city)
    end

    it "I can apply to adopt pets" do
      app_info = {name: "Joe", address: "12879 Maple St", city: "Denver", state: "CO", zip: "80211", phone_number: "202-131-5131", description: "I have snacks!"}
      visit "/pets/#{@pet_1.id}"
      click_link("Add to Favorites")
      visit "/pets/#{@pet_2.id}"
      click_link("Add to Favorites")
      visit '/favorites'

      click_link("Apply for Pets")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_css("#checkbox-#{@pet_1.id}")
      expect(page).to have_css("#checkbox-#{@pet_2.id}")
      expect(page).to_not have_css("#checkbox-#{@pet_3.id}")

      within("#checkbox-#{@pet_1.id}") { check "applied_for_" }

      fill_in 'Name', with: app_info[:name]
      fill_in 'Address', with: app_info[:name]
      fill_in 'City', with: app_info[:city]
      fill_in 'State', with: app_info[:state]
      fill_in 'Zip', with: app_info[:zip]
      fill_in 'Phone number', with: app_info[:phone_number]
      fill_in "Description", with: app_info[:description]
      click_button "Submit Application"

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("You have successfully submitted your application!")

      expect(page).to_not have_css("#pet-#{@pet_1.id}")
      expect(page).to have_css("#pet-#{@pet_2.id}")
    end

    it "I see an error if I don't fill in all fields in application" do
      app_info = {name: "Joe", address: "12879 Maple St", city: "Denver", state: "CO", zip: "80211", phone_number: "202-131-5131", description: "I have snacks!"}
      visit "/pets/#{@pet_1.id}"
      click_link("Add to Favorites")
      visit "/pets/#{@pet_2.id}"
      click_link("Add to Favorites")
      visit '/favorites'

      click_link("Apply for Pets")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_css("#checkbox-#{@pet_1.id}")
      expect(page).to have_css("#checkbox-#{@pet_2.id}")
      expect(page).to_not have_css("#checkbox-#{@pet_3.id}")

      within("#checkbox-#{@pet_1.id}") { check "applied_for_" }

      fill_in 'Name', with: app_info[:name]
      fill_in 'Address', with: app_info[:name]
      fill_in 'City', with: app_info[:city]
      fill_in 'State', with: app_info[:state]
      fill_in 'Phone number', with: app_info[:phone_number]
      fill_in "Description", with: app_info[:description]
      click_button "Submit Application"

      expect(page).to have_content("You must complete the form in order to submit the application.")

      fill_in 'Name', with: app_info[:name]
      fill_in 'Address', with: app_info[:name]
      fill_in 'City', with: app_info[:city]
      fill_in 'State', with: app_info[:state]
      fill_in 'Zip', with: app_info[:zip]
      fill_in 'Phone number', with: app_info[:phone_number]
      fill_in "Description", with: app_info[:description]
      click_button "Submit Application"

      expect(page).to have_content("You must complete the form in order to submit the application.")
    end
  end
end

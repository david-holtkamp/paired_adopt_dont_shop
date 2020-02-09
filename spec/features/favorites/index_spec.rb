require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "From the favorites index page" do
    before(:each) do
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

    it "I can see all pets I've favorited" do
      visit "/pets/#{@pet_1.id}"
      click_link("Add to Favorites")

      visit "/pets/#{@pet_2.id}"
      click_link("Add to Favorites")

      visit '/favorites'

      expect(page).to have_link(@pet_1.name)
      expect(page).to have_css("img[src*='#{@pet_1.image}']")
      expect(page).to have_link(@pet_2.name)
      expect(page).to have_css("img[src*='#{@pet_2.image}']")
    end

    it "I see a message when I have no favorites" do
      visit '/favorites'

      expect(page).to have_content("You have no favorited pets")
    end

    it "I see a section of all pets that have been applied for" do
      app_info = {name: "Joe", address: "12879 Maple St", city: "Denver", state: "CO", zip: "80211", phone_number: "202-131-5131", description: "I have snacks!"}
      visit "/pets/#{@pet_1.id}"
      click_link("Add to Favorites")
      visit "/pets/#{@pet_2.id}"
      click_link("Add to Favorites")
      visit "/pets/#{@pet_3.id}"
      click_link("Add to Favorites")

      visit '/favorites'

      click_link("Apply for Pets")

      expect(current_path).to eq("/applications/new")
      expect(page).to have_css("#pet_id-#{@pet_1.id}")
      expect(page).to have_css("#pet_id-#{@pet_2.id}")
      expect(page).to have_css("#pet_id-#{@pet_3.id}")

      check "pet_id-#{@pet_1.id}"
      check "pet_id-#{@pet_2.id}"

      fill_in 'Name', with: app_info[:name]
      fill_in 'Address', with: app_info[:name]
      fill_in 'City', with: app_info[:city]
      fill_in 'State', with: app_info[:state]
      fill_in 'Zip', with: app_info[:zip]
      fill_in 'Phone number', with: app_info[:phone_number]
      fill_in "Description", with: app_info[:description]
      click_button "Submit Application"

      expect(page).to have_content("Pets with Applications")

      within '#pets-with-applications' do
        expect(page).to have_link(@pet_1.name)
        expect(page).to have_link(@pet_2.name)
        expect(page).to_not have_link(@pet_3.name)
      end
      #test that there aren't duplicate pet links for pets that have multiple applications
      visit "/pets/#{@pet_1.id}"
      click_link("Add to Favorites")
      visit '/favorites'

      click_link("Apply for Pets")

      check "pet_id-#{@pet_1.id}"

      fill_in 'Name', with: app_info[:name]
      fill_in 'Address', with: app_info[:name]
      fill_in 'City', with: app_info[:city]
      fill_in 'State', with: app_info[:state]
      fill_in 'Zip', with: app_info[:zip]
      fill_in 'Phone number', with: app_info[:phone_number]
      fill_in "Description", with: app_info[:description]
      click_button "Submit Application"

      expect(page).to have_content("Pets with Applications")

      within '#pets-with-applications' do
        expect(page).to have_link(@pet_1.name, count: 1)
        expect(page).to have_link(@pet_2.name)
        expect(page).to_not have_link(@pet_3.name)
      end
    end
  end
end

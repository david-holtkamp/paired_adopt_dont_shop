require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the pet show page" do
    before :each do
      Pet.destroy_all
      Shelter.destroy_all
      @dog_city = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @pet_1 = Pet.create!(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: @dog_city)

      @pet_2 = Pet.create!(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: @dog_city)

      visit "/pets/#{@pet_1.id}"
    end

    it "I can remove pet from favorites" do

      expect(page).to_not have_link("Remove from Favorites")

      click_link "Add to Favorites"

      within('nav') { expect(page).to have_link('FAVORITES: 1')}
      expect(page).to_not have_link("Add to Favorites")

      click_link "Remove from Favorites"

      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("#{@pet_1.name} has been removed from favorites.")
      expect(page).to have_link("Add to Favorites")
      within('nav') { expect(page).to have_link('FAVORITES: 0')}
    end

    it "I can remove pet from favorites page" do
      click_link "Add to Favorites"

      visit "/pets/#{@pet_2.id}"

      click_link "Add to Favorites"

      visit '/favorites'

      within("#pet-#{@pet_1.id}") do
        expect(page).to have_link("Remove from Favorites")
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to have_link("Remove from Favorites")
        click_link "Remove from Favorites"
      end

      expect(current_path).to eq('/favorites')
      within('nav') { expect(page).to have_link('FAVORITES: 1')}
      expect(page).to_not have_css("#pet-#{@pet_2.id}")
      expect(page).to have_css("#pet-#{@pet_1.id}")      
    end
  end
end

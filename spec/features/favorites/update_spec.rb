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

      visit "/pets/#{@pet_1.id}"
    end

    it "I see a message when I add a pet to my favorites" do
      click_link("Add to Favorites")

      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("#{@pet_1.name} has been added to favorites!")
    end

    it "I see the favorite indicator count increment when I add favorites" do
      within('nav') { expect(page).to have_content("FAVORITES: 0")}

      click_link("Add to Favorites")

      within('nav') { expect(page).to have_content("FAVORITES: 1")}
    end
  end
end

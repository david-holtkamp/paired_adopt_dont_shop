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
      visit "/pets/#{@pet_1.id}"
      click_link("Add to Favorites")

      visit "/pets/#{@pet_2.id}"
      click_link("Add to Favorites")
    end
    it "I can see all pets I've favorited" do
      visit '/favorites'

      expect(page).to have_link(@pet_1.name)
      expect(page).to have_css("img[src*='#{@pet_1.image}']")
      expect(page).to have_link(@pet_2.name)
      expect(page).to have_css("img[src*='#{@pet_2.image}']")
    end
  end
end

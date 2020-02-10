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
      @app_1 = Application.create({
        name: "David H",
        address: "1234 julian st.",
        city: "Denver",
        state: "CO",
        zip: "80211",
        phone_number: "303-465-1112",
        description: "I like dogs."
        })
      @app_2 = Application.create({
        name: "David A",
        address: "1234 elm st.",
        city: "Denver",
        state: "CO",
        zip: "80212",
        phone_number: "303-465-4443",
        description: "I like dog."
        })

        @app_1.pets << [@pet_1, @pet_2]
        @app_2.pets << @pet_1
    end
    it "I can view all applications for this pet" do
      visit "/pets/#{@pet_1.id}"

      expect(page).to have_link("View All Applications for #{@pet_1.name}")

      click_link "View All Applications for #{@pet_1.name}"

      expect(current_path).to eq("/pets/#{@pet_1.id}/applications")

      expect(page).to have_link(@app_1.name)
      expect(page).to have_link(@app_2.name)

      click_link "#{@app_1.name}"
      expect(current_path).to eq("/applications/#{@app_1.id}")

      visit "/pets/#{@pet_2.id}"

      expect(page).to have_link("View All Applications for #{@pet_2.name}")

      click_link "View All Applications for #{@pet_2.name}"

      expect(current_path).to eq("/pets/#{@pet_2.id}/applications")
      expect(page).to have_link(@app_1.name)

      click_link "#{@app_1.name}"

      expect(current_path).to eq("/applications/#{@app_1.id}")
    end
  end
end

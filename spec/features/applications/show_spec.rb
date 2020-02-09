require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the application show page" do
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
      @app_1 = Application.create!(
        name: "Guy",
        address: "23 Guy St",
        city: "Guy City",
        state: "CO",
        zip: "12345",
        phone_number: "303-210-2301",
        description: "Just a regular guy.")
      @app_1.pets << [@pet_1, @pet_2, @pet_3]

      visit "/applications/#{@app_1.id}"
    end

    it "I can see an application's information" do
      expect(page).to have_content("Name: #{@app_1.name}")
      expect(page).to have_content("Address: #{@app_1.address}")
      expect(page).to have_content("City: #{@app_1.city}")
      expect(page).to have_content("State: #{@app_1.state}")
      expect(page).to have_content("Zip: #{@app_1.zip}")
      expect(page).to have_content("Phone Number: #{@app_1.phone_number}")
      expect(page).to have_content("Description: #{@app_1.description}")
      expect(page).to have_content("Pets On Application:")
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_link(@pet_2.name)
      expect(page).to have_link(@pet_3.name)
    end
  end
end

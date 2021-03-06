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

    it "I can see the info of the pet" do
      expect(page).to have_css("img[src*='#{@pet_1.image}']")
      expect(page).to have_content("Name: #{@pet_1.name}", count: 1)
      expect(page).to have_content("Description: #{@pet_1.description}", count: 1)
      expect(page).to have_content("Age: #{@pet_1.age}", count: 1)
      expect(page).to have_content("Sex: #{@pet_1.sex}", count: 1)
      expect(page).to have_content("Status: #{@pet_1.status}", count: 1)

      expect(page).to_not have_content(@pet_2.name)
      expect(page).to_not have_content(@pet_2.description)
      expect(page).to_not have_content(@pet_2.age)
      expect(page).to_not have_content(@pet_2.sex)
    end

    it "I can see a link to application show page" do
      app_1 = Application.create({
        name: "David H",
        address: "1234 julian st.",
        city: "Denver",
        state: "CO",
        zip: "80211",
        phone_number: "303-465-1112",
        description: "I like dogs."
        })

      app_1.pets << @pet_1

      visit "/applications/#{app_1.id}"
      within("#pet-#{@pet_1.id}") { click_link('Approve Application')}

      expect(page).to have_link(app_1.name)
    end
  end
end

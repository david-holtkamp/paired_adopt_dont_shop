require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the pet show page" do
    it "I can get to the update page, fill in all fields of the update form, and submit the changes" do
      dog_city = Shelter.create!(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
      pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: dog_city)
      pet_2 = Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        shelter: dog_city)
      updated_info = {
        image: "https://i.pinimg.com/236x/8d/28/e3/8d28e38a62466f9ef4166703fd5fe45f--nate-dogg-west-coast.jpg",
        name: "Snoop Dogg",
        description: "now you know you in trouble",
        age: "like 60 years old",
        sex: "alpha male"}

      visit "/pets/#{pet_1.id}"
      click_link("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in 'image', with: updated_info[:image]
      fill_in 'name', with: updated_info[:name]
      fill_in 'description', with: updated_info[:description]
      fill_in 'age', with: updated_info[:age]
      fill_in 'sex', with: updated_info[:sex]

      click_button("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_css("img[src*='#{updated_info[:image]}']")
      expect(page).to have_content(updated_info[:name])
      expect(page).to have_content(updated_info[:description])
      expect(page).to have_content(updated_info[:age])
      expect(page).to have_content(updated_info[:sex])
      expect(page).to have_content("Adoptable")

      expect(page).to_not have_css("img[src*='#{pet_2.image}']")
      expect(page).to_not have_content(pet_2.name)
      expect(page).to_not have_content(pet_2.description)
      expect(page).to_not have_content(pet_2.age)
      expect(page).to_not have_content(pet_2.sex)
    end

    it "I can get to the update page, fill in all fields of the update form, and submit the changes" do
      dog_city = Shelter.create!(name: "Dog City", address: "1923 Dog Ln", city: "Doggington", state: "CO", zip: "80414")
      pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: dog_city)
      updated_info = {
        image: "https://i.pinimg.com/236x/8d/28/e3/8d28e38a62466f9ef4166703fd5fe45f--nate-dogg-west-coast.jpg",
        name: "Snoop Dogg",
        description: "now you know you in trouble",
        age: "like 60 years old",
        sex: "alpha male"}

      visit "/pets/#{pet_1.id}"
      click_link("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}/edit")

      fill_in 'image', with: updated_info[:image]
      fill_in 'name', with: ''
      fill_in 'description', with: updated_info[:description]
      fill_in 'age', with: updated_info[:age]
      fill_in 'sex', with: ''

      click_button("Update Pet")

      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("Failed to update pet: Name can't be blank and Sex can't be blank")
      expect(page).to_not have_css("img[src*='#{updated_info[:image]}']")
      expect(page).to_not have_content(updated_info[:name])
      expect(page).to_not have_content(updated_info[:description])
      expect(page).to_not have_content(updated_info[:age])
      expect(page).to_not have_content(updated_info[:sex])

      expect(page).to have_css("img[src*='#{pet_1.image}']")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.description)
      expect(page).to have_content(pet_1.age)
      expect(page).to have_content(pet_1.sex)
    end
  end
end

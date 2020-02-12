require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from any page" do
    before :each do
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
      end

      it "I can see a favorite indicator in the nav bar" do
        visit '/'
        within('nav') { expect(page).to have_link('FAVORITES') }

        visit '/shelters'
        within('nav') { expect(page).to have_link('FAVORITES') }

        visit "/shelters/#{@dog_city.id}"
        within('nav') { expect(page).to have_link('FAVORITES') }

        visit "/pets/#{@pet_1.id}"
        within('nav') { expect(page).to have_link('FAVORITES') }
    end
  end
end

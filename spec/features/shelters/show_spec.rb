require 'rails_helper'

RSpec.describe "As a visitor:" do
  describe "from the shelter show page" do
    before :each do
      @shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")
      @shelter_2 = Shelter.create!(
        name: "Dog City",
        address: "1923 Dog Ln",
        city: "Doggington",
        state: "CO",
        zip: "80414")
      @img_review = Review.create!(
        title: "omg!!!",
        rating: 4,
        content: "pets super amazin!!",
        image: "https://cdn0.wideopenpets.com/wp-content/uploads/2016/04/valentines-8.jpg",
        shelter: @shelter_1
      )
      @no_img_review = Review.create!(
        title: "eh",
        rating: 3,
        content: "it's ok I guess",
        shelter: @shelter_1
      )
      @pet_1 = Pet.create(
        image: "https://i.pinimg.com/originals/a9/cf/64/a9cf6473ca327409108ab02d15cc06b0.jpg",
        name: "Snoopy",
        description: "beagle pup eh",
        age: "6 months old",
        sex: "male",
        shelter: @shelter_1)

      @pet_2 = Pet.create(
        image: "https://upload.wikimedia.org/wikipedia/commons/2/2b/WelshCorgi.jpeg",
        name: "Nana",
        description: "super cute dog in need of home",
        age: "4 years old",
        sex: "female",
        status: "Pending",
        shelter: @shelter_1)

      @pet_3 = Pet.create!(
        image: "https://cdn.mos.cms.futurecdn.net/g8PyY6xAhcndpQLLSkdPf-320-80.jpg",
        name: "Capy'n Hook",
        description: "dread of the seven seas",
        age: "400 years old?",
        sex: "male",
        shelter: @shelter_1)

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

      visit "/shelters/#{@shelter_1.id}"
    end

    it "I can see the info of the shelter" do
      expect(page).to have_content("Name: #{@shelter_1.name}", count: 1)
      expect(page).to have_content("Address: #{@shelter_1.address}", count: 1)
      expect(page).to have_content("City: #{@shelter_1.city}", count: 1)
      expect(page).to have_content("State: #{@shelter_1.state}", count: 1)
      expect(page).to have_content("Zip: #{@shelter_1.zip}", count: 1)

      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_2.address)
      expect(page).to_not have_content(@shelter_2.city)
      expect(page).to_not have_content(@shelter_2.state)
      expect(page).to_not have_content(@shelter_2.zip)
    end

    it "I see a list of reviews for that shelter" do
      within("#review-#{@img_review.id}") do
        expect(page).to have_content("#{@img_review.title}")
        expect(page).to have_content("Rating: #{@img_review.rating}")
        expect(page).to have_content("Content: #{@img_review.content}")
        expect(page).to have_css("img[src*='#{@img_review.image}']")
      end

      within("#review-#{@no_img_review.id}") do
        expect(page).to have_content("#{@no_img_review.title}")
        expect(page).to have_content("#{@no_img_review.rating}")
        expect(page).to have_content("#{@no_img_review.content}")
        expect(page).to have_css('img')
      end
    end

    it "I can see shelter statistics" do
      expect(page).to have_content("Count of Pets: 3")
      expect(page).to have_content("Average Review Rating: 3.5")
      expect(page).to have_content("Number of Applicants: 2")
    end
  end
end

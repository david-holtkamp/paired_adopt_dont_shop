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
        rating: 5,
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
        expect(page).to have_content("Title: #{@img_review.title}")
        expect(page).to have_content("Rating: #{@img_review.rating}")
        expect(page).to have_content("Content: #{@img_review.content}")
        expect(page).to have_css("img[src*='#{@img_review.image}']")
      end

      within("#review-#{@no_img_review.id}") do
        expect(page).to have_content("#{@no_img_review.title}")
        expect(page).to have_content("#{@no_img_review.rating}")
        expect(page).to have_content("#{@no_img_review.content}")
        expect(page).to_not have_css('img')
      end
    end
  end
end

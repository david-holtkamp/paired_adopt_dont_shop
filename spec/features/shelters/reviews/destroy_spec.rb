require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "from the shelter show page" do
    before(:each) do
      @shelter_1 = Shelter.create!(
        name: "Shelter A",
        address: "123 Fake St",
        city: "Las Vegas",
        state: "WY",
        zip: "12345")

      @img_review = Review.create!(
        title: "omg!!!",
        rating: 5,
        content: "pets super amazin!!",
        image: "https://cdn0.wideopenpets.com/wp-content/uploads/2016/04/valentines-8.jpg",
        shelter: @shelter_1)

      @no_img_review = Review.create!(
        title: "eh",
        rating: 3,
        content: "it's ok I guess",
        shelter: @shelter_1)
    end
    it "I can see a delete button next to all reviews" do
      visit "/shelters/#{@shelter_1.id}"

      within("#review-#{@img_review.id}") do
        expect(page).to have_link("Delete Review")
      end

      within("#review-#{@no_img_review.id}") do
        expect(page).to have_link("Delete Review")
      end
    end
    it "I can delete any review" do
      visit "/shelters/#{@shelter_1.id}"

      within("#review-#{@img_review.id}") { click_on("Delete Review") }

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")
      expect(page).to_not have_content("#{@img_review[:title]}")
      expect(page).to_not have_content("Rating: #{@img_review[:rating]}")
      expect(page).to_not have_content("Content: #{@img_review[:content]}")
    end
  end
end

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
      @review_with_image = Review.create!(
        title: "omg!!!",
        rating: 5,
        content: "pets super amazin!!",
        image: "https://cdn0.wideopenpets.com/wp-content/uploads/2016/04/valentines-8.jpg",
        shelter: @shelter_1
      )
      @review_without_image = Review.create!(
        title: "eh",
        rating: 3,
        content: "it's ok I guess",
        shelter: @shelter_1
      )
      @new_review_no_img = {
        title: "new title",
        rating: 1,
        content: "this is the new review",
      }
      @new_review_with_image = {
        title: "other review",
        rating: 4,
        content: "this one should have a picture!",
        image: 'https://s3.amazonaws.com/petcentral.com/wp-content/uploads/2019/10/31153735/delfiepic.jpg'
      }

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
      within("#review-#{@review_with_image.id}") do
        expect(page).to have_content("Title: #{@review_with_image.title}")
        expect(page).to have_content("Rating: #{@review_with_image.rating}")
        expect(page).to have_content("Content: #{@review_with_image.content}")
        expect(page).to have_css("img[src*='#{@review_with_image.image}']")
      end

      within("#review-#{@review_without_image.id}") do
        expect(page).to have_content("#{@review_without_image.title}")
        expect(page).to have_content("#{@review_without_image.rating}")
        expect(page).to have_content("#{@review_without_image.content}")
        #test that it has no image whatsoever
      end
    end

    it "I can add a new review with no image" do
      click_link("New Review")
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/new_review")

      fill_in 'title', with: @new_review_no_img[:title]
      fill_in 'rating', with: @new_review_no_img[:rating]
      fill_in 'content', with: @new_review_no_img[:content]

      click_button('Add Review')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("Title: #{@new_review_no_img[:title]}")
      expect(page).to have_content("Rating: #{@new_review_no_img[:rating]}")
      expect(page).to have_content("Content: #{@new_review_no_img[:content]}")
    end

    it "I can add a new review with an image" do
      click_link("New Review")
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/new_review")

      fill_in 'title', with: @new_review_with_image[:title]
      fill_in 'rating', with: @new_review_with_image[:rating]
      fill_in 'content', with: @new_review_with_image[:content]
      fill_in 'image', with: @new_review_with_image[:image]

      click_button('Add Review')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("Title: #{@new_review_with_image[:title]}")
      expect(page).to have_content("Rating: #{@new_review_with_image[:rating]}")
      expect(page).to have_content("Content: #{@new_review_with_image[:content]}")
    end
  end
end

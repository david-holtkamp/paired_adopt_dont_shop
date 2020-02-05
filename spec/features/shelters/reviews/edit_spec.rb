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
      @no_img_info = {
        title: "new title",
        rating: 1,
        content: "this is the new review",
      }
      @img_info = {
        title: "other review",
        rating: 4,
        content: "this one should have a picture!",
        image: 'https://s3.amazonaws.com/petcentral.com/wp-content/uploads/2019/10/31153735/delfiepic.jpg'
      }

      visit "/shelters/#{@shelter_1.id}"
    end

    it "I can edit a review and add an image" do
      within("#review-#{@no_img_review.id}") { click_link("Edit Review") }

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@no_img_review.id}/edit")

      expect(page).to have_field('Title', with: @no_img_review[:title])
      expect(page).to have_field('Rating', with: @no_img_review[:rating])
      expect(page).to have_field('Content', with: @no_img_review[:content])

      fill_in 'title', with: @img_info[:title]
      fill_in 'rating', with: @img_info[:rating]
      fill_in 'content', with: @img_info[:content]
      fill_in 'image', with: @img_info[:image]

      click_button('Update Review')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within("#review-#{@no_img_review.id}") do
        expect(page).to have_content("Title: #{@img_info[:title]}")
        expect(page).to have_content("Rating: #{@img_info[:rating]}")
        expect(page).to have_content("Content: #{@img_info[:content]}")
        expect(page).to have_css("img[src*='#{@img_info[:image]}']")
        expect(page).to_not have_content("Title: #{@no_img_review[:title]}")
        expect(page).to_not have_content("Rating: #{@no_img_review[:rating]}")
        expect(page).to_not have_content("Content: #{@no_img_review[:content]}")
      end
    end

    it "I can edit a review and remove an image" do
      within("#review-#{@img_review.id}") { click_link("Edit Review") }

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@img_review.id}/edit")

      expect(page).to have_field('Title', with: @img_review[:title])
      expect(page).to have_field('Rating', with: @img_review[:rating])
      expect(page).to have_field('Content', with: @img_review[:content])

      fill_in 'title', with: @no_img_info[:title]
      fill_in 'rating', with: @no_img_info[:rating]
      fill_in 'content', with: @no_img_info[:content]
      fill_in 'image', with: ''

      click_button('Update Review')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within("#review-#{@img_review.id}") do
        expect(page).to have_content("Title: #{@no_img_info[:title]}")
        expect(page).to have_content("Rating: #{@no_img_info[:rating]}")
        expect(page).to have_content("Content: #{@no_img_info[:content]}")
        expect(page).to_not have_css('img')
        expect(page).to_not have_content("Title: #{@img_review[:title]}")
        expect(page).to_not have_content("Rating: #{@img_review[:rating]}")
        expect(page).to_not have_content("Content: #{@img_review[:content]}")
      end
    end
    it "I cannot edit a review without required fields completed" do
      within("#review-#{@img_review.id}") { click_link("Edit Review") }

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/#{@img_review.id}/edit")

      fill_in 'title', with: ''
      fill_in 'rating', with: ''
      fill_in 'content', with: ''
      fill_in 'image', with: ''

      click_button('Update Review')

      expect(page).to have_content("You need to fill in a title, rating, and content in order to edit a shelter review")
      expect(page).to have_button("Update Review")
    end
  end
end

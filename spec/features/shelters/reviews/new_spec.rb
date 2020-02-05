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

    it "I can add a new review with no image" do
      click_link("New Review")

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in 'title', with: @no_img_info[:title]
      fill_in 'rating', with: @no_img_info[:rating]
      fill_in 'content', with: @no_img_info[:content]

      click_button('Add Review')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within("#review-#{Review.last.id}") do
        expect(page).to have_content("Title: #{@no_img_info[:title]}")
        expect(page).to have_content("Rating: #{@no_img_info[:rating]}")
        expect(page).to have_content("Content: #{@no_img_info[:content]}")
        expect(page).to_not have_css('img')
        expect(page).to_not have_content("Title: #{@img_review[:title]}")
        expect(page).to_not have_content("Title: #{@no_img_review[:title]}")
      end
    end

    it "I can add a new review with an image" do
      click_link("New Review")

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      fill_in 'title', with: @img_info[:title]
      fill_in 'rating', with: @img_info[:rating]
      fill_in 'content', with: @img_info[:content]
      fill_in 'image', with: @img_info[:image]

      click_button('Add Review')

      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      within("#review-#{Review.last.id}") do
        expect(page).to have_content("Title: #{@img_info[:title]}")
        expect(page).to have_content("Rating: #{@img_info[:rating]}")
        expect(page).to have_content("Content: #{@img_info[:content]}")
        expect(page).to have_css("img[src*='#{@img_info[:image]}']")
        expect(page).to_not have_content("Title: #{@img_review[:title]}")
        expect(page).to_not have_content("Title: #{@no_img_review[:title]}")
      end
    end

    it "I cannot create a review without required fields completed" do
      click_link("New Review")

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")

      click_button("Add Review")

      expect(page).to have_content("You need to fill in a title, rating, and content in order to submit a shelter review")
      expect(page).to have_button("Add Review")
    end

  end
end

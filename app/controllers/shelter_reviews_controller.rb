class ShelterReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    Review.create(review_params)

    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :image, :shelter_id)
    end
end

class ReviewsController < ApplicationController
  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    attempt_create(review)
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    @review = Review.find(params[:review_id])
    if @review.update(review_params)
      @review.update(image: linkify(@review.image)) if is_invalid?(@review.image)
      redirect_to("/shelters/#{params[:shelter_id]}")
    else
      invalid_edit
    end
  end

  def destroy
    Review.delete(params[:review_id])
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  private

    def review_params
      if (params[:image] == '')
        params.permit(:title, :rating, :content, :shelter_id)
      else
        params.permit(:title, :rating, :content, :image, :shelter_id)
      end
    end

    def invalid_edit
      flash[:notice] = @review.errors.full_messages.to_sentence
      render :edit
    end

    def attempt_create(review)
      review.update(image: linkify(review.image)) if is_invalid?(review.image)
      review.save ? redirect_to("/shelters/#{params[:shelter_id]}") : fail_create(review)
    end

    def fail_create(review)
      @shelter_id = params[:shelter_id]
      flash.now[:notice] = review.errors.full_messages.to_sentence
      render :new
    end
end

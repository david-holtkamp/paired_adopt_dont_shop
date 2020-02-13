class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      flash[:notice] = "Shelter created!"
      redirect_to '/shelters'
    else
      flash.now[:error] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    if shelter.update(shelter_params)
      flash[:notice] = "Shelter updated!"
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:error] = shelter.errors.full_messages.to_sentence
      redirect_to "/shelters/#{shelter.id}/edit"
    end
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets.pending.empty?
      favorites.delete_pets(shelter.pets.pluck(:id))
      Shelter.destroy(shelter.id)
    else
      flash[:notice] = "You cannot delete a shelter with approved pets."
    end
    redirect_to '/shelters'
  end

  private

    def shelter_params
      params.permit(:name, :address, :city, :state, :zip)
    end
end

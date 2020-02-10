class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_pets = @shelter.pets.sort_by_status if params[:adoptable].nil?
    @shelter_pets = @shelter.pets.adoptable if params[:adoptable] == 'true'
    @shelter_pets = @shelter.pets.pending if params[:adoptable] == 'false'
  end

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    Pet.create(pet_params)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex, :shelter_id)
    end
end

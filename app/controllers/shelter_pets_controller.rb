class ShelterPetsController < ApplicationController
  def index
    @shelter = Shelter.find(params[:shelter_id])
    if params[:adoptable]
      if (params[:adoptable] == 'true')
        @pets = @shelter.pets.adoptable
        @pet_count = @shelter.pet_count("Adoptable")
        @adoptable = true
      else
        @pets = @shelter.pets.pending
        @pet_count = @shelter.pet_count("Pending")
        @pending = true
      end
    else
      @pets = @shelter.pets.sort_by_status
      @pet_count = @shelter.pet_count
    end
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

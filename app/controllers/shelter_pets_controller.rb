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
    pet = Pet.new(pet_params)
    flash[:notice] = "Failed to create pet: #{pet.errors.full_messages.to_sentence}" if !pet.save
    pet.update(image: linkify(pet.image)) if is_invalid?(pet.image)
    redirect_to "/shelters/#{params[:shelter_id]}/pets"
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex, :shelter_id)
    end
end

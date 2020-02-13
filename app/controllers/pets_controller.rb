class PetsController < ApplicationController
  def welcome
    redirect_to '/pets'
  end

  def index
    @pets = Pet.all.sort_by_status if params[:adoptable].nil?
    @pets = Pet.adoptable if params[:adoptable] == "true"
    @pets = Pet.pending if params[:adoptable] == "false"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    flash[:notice] = "Failed to update pet: #{pet.errors.full_messages.to_sentence}" if !pet.update(pet_params)
    pet.update(image: linkify(pet.image)) if is_invalid?(pet.image)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    destroy_attempt(pet)
    redirect_to '/pets'
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex)
    end

    def destroy_attempt(pet)
      if pet.status == "Pending"
        flash[:notice] = "You cannot delete a pet with an approved application."
      else
        Pet.destroy(pet.id)
        favorites.delete_pet(pet.id)
      end
    end
end

class PetsController < ApplicationController
  def welcome
    redirect_to '/pets'
  end

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    Pet.delete(params[:id])

    redirect_to '/pets'
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex)
    end
end

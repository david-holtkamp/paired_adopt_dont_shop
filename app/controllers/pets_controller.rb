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
    pet.update(pet_params)
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:id])
    if pet.status == "Pending"
      flash[:notice] = "You cannot delete a pet with an approved application."
    else
      Pet.destroy(pet.id)
    end
    redirect_to '/pets'
  end

  private

    def pet_params
      params.permit(:image, :name, :description, :age, :sex)
    end
end

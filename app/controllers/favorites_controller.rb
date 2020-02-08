class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} has been added to favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end

  def index
    @pets = Pet.find(favorites.contents)
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.delete_pet(pet.id)
    flash[:notice] = "#{pet.name} has been removed from favorites."
    session[:favorites] = favorites.contents
    redirect_back(fallback_location: "/favorites")
  end
end

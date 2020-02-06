class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    # favorites.add_pet(pet.id)
    favorites.add_pet({id: pet.id, info: {name: pet.name, image: pet.image}})
    session[:favorites] = favorites.contents
    flash[:notice] = "#{pet.name} has been added to favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end

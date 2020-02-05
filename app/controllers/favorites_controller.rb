class FavoritesController < ApplicationController
  def update
    pet = Pet.find(params[:pet_id])
    flash[:notice] = "#{pet.name} has been added to favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end

class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:pet_id])
    pet_id_str = pet.id.to_s
    session[:favorites] ||= Hash.new #Array.new
    session[:favorites][pet_id_str] ||= true

    # session[:favorites].index(pet_id_str) || pet_id_str

    flash[:notice] = "#{pet.name} has been added to favorites!"
    redirect_to "/pets/#{params[:pet_id]}"
  end
end

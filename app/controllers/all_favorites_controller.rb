class AllFavoritesController < ApplicationController
  def destroy
    favorites.reset
    session[:favorites] = favorites.contents
    redirect_back(fallback_location: "/favorites")
  end
end

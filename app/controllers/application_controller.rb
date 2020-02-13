class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites, :is_invalid?, :linkify

  def favorites
    @favorites ||= Favorites.new(session[:favorites])
  end

  def is_invalid?(path)
    path.index("http://") != 0 && path.index("https://") != 0
  end

  def linkify(path)
    path.prepend("https://")
  end
end

class FavoritesController < ApplicationController
  before_action :require_login

  def create
    movie = Movie.find(params[:movie_id])
    movie.fans << current_user

    # this would also work
    # @movie.favorites.create!(user: current_user)

    redirect_to movie, notice: "Added to favorites!"
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    favorite.destroy

    redirect_to favorite.movie, notice: "Removed from favorites!"
  end
end

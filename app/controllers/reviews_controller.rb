class ReviewsController < ApplicationController
  before_action :set_movie
  def index
    @reviews = @movie.reviews
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end

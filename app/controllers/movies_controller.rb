class MoviesController < ApplicationController
  before_action :set_movie, only: [ :show, :edit, :update, :destroy ]

  def index
    @movies = Movie.released
  end

  def show
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render :edit, status: :unprocessable_content
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
     redirect_to @movie
    else
      render :new, status: :unprocessable_content
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_url, status: :see_other
  end

  private
  def movie_params
    params.expect(movie: [ :title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name ])
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end
end

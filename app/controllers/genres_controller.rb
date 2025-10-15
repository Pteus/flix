class GenresController < ApplicationController
  before_action :require_admin, except: [ :index, :show ]
  before_action :set_genre, only: [ :show, :destroy, :edit, :update ]
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def new
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to @genre, notice: "Genre was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @genre.update(genre_params)
      redirect_to @genre, notice: "Genre was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @genre.destroy
    redirect_to genres_url, status: :see_other, alert: "Genre was successfully deleted."
  end

  private
  def genre_params
    params.expect(genre: [ :name ])
  end

  def set_genre
    @genre = Genre.find(params[:id])
  end
end

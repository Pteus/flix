class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_movie
  before_action :set_review, only: [ :edit, :update, :destroy ]

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to @movie, notice: "Review was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @movie, notice: "Review was successfully updated."
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @review.destroy
    redirect_to movie_url, status: :see_other, danger: "Review was successfully destroyed."
  end
  private

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.expect(review: [ :stars, :comment ])
  end
end

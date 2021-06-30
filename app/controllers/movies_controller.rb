class MoviesController < ApplicationController

  before_action :authenticate!, only: [:create, :update, :destroy]
  before_action :authorize!, only: [:create, :update, :destroy]

  def index
    render json: Movie.all
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    @movie.save!
    render json: @movie
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update!(movie_params)
    render json: @movie
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy!
    render json: @movie
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director, :rating)
  end

  def authenticate!
    raise Errors::Unauthorized unless current_user
  end

  def authorize!
    raise Errors::Unauthorized unless current_user.role.eql? 'admin'
  end
end

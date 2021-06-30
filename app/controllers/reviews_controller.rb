class ReviewsController < ApplicationController
  before_action :authenticate!, only: %i[create update destroy]
  before_action :set_review, only: %i[update destroy]
  before_action :authorize!, only: %i[update destroy]

  def index
    if params[:book_id]
      @reviews = Review.where(reviewable_id: params[:book_id])
                       .where(reviewable_type: 'Book')
    elsif params[:movie_id]
      @reviews = Review.where(reviewable_id: params[:movie_id])
                       .where(reviewable_type: 'Movie')
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @reviews = @user.reviews
    else
      @reviews = Review.all
    end

    render json: @reviews
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    if params[:movie_id]
      @review.reviewable = Movie.find_by(id: params[:movie_id])
    elsif params[:book_id]
      @review.reviewable = Book.find_by(id: params[:book_id])
    else
      render json: { errors: @review.errors, message: 'Check the api request properly' },
             status: :unprocessable_entity
    end
    raise Errors::NotFound unless @review.reviewable

    @review.save!
    render json: @review, status: :created, location: @review
  end

  def show
    @review = Review.find(params[:id])
    render json: @review
  end

  def update
    @review.update!(review_params)
    render json: @review
  end

  def destroy
    @review.destroy!
    render json: @review
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def authenticate!
    raise Errors::Unauthorized unless current_user
  end

  def authorize!
    raise Errors::Unauthorized unless @current_user.id == @review.user.id
  end

  def review_params
    params.require(:review).permit(:content)
  end
end

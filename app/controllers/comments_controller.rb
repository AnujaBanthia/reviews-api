class CommentsController < ApplicationController
  before_action :authenticate!, only: %i[create update destroy]
  before_action :set_comment, only: %i[update destroy]
  before_action :authorize!, only: %i[update destroy]

  def index
    if params[:review_id]
        @comments = Comment.where(review_id: params[:review_id])
      else
        @comments = Comment.all
      end
      render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.review = Review.find(params[:review_id])
    @comment.user = current_user

    @comment.save!
    render json: @comment
  end

  def show
    @comment = Comment.find(params[:id])
    render json: @comment
  end
  
  def update
    @comment.update!(comment_params)
    render json: @comment
  end

  def destroy
    @comment.destroy!
    render json: @comment
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authenticate!
    raise Errors::Unauthorized unless current_user
  end

  def authorize!
    raise Errors::Unauthorized unless @current_user.id == @comment.user.id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end

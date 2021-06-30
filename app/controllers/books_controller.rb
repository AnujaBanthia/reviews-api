class BooksController < ApplicationController

  before_action :authenticate!, only: [:create, :update, :destroy]
  before_action :authorize!, only: [:create, :update, :destroy]

  def index
    render json: Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @book.save!
    render json: @book
  end

  def update
    @book = Book.find(params[:id])
    @book.update!(book_params)
    render json: @book
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy!
    render json: @book
  end

  def show
    @book = Book.find(params[:id])
    render json: @book
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :rating)
  end

  def authenticate!
    raise Errors::Unauthorized unless current_user
  end

  def authorize!
    raise Errors::Unauthorized unless current_user.role.eql? 'admin'
  end
end

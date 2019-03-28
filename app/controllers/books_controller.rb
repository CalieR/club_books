class BooksController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    @book = Book.find_or_search_by(params[:title])
    redirect_to @book
  end

  def show
    @book = Book.find(params[:id])
    session[:book_id] = @book.id
    @club = Club.find(session[:club_id])
  end

  private

  def require_login
    authorised?
  end
end

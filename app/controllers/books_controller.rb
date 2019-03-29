class BooksController < ApplicationController
  # user has to be logged in before they can access any books
  before_action :require_login

  # search page
  def new
  end

# calls the method defined in the book model when user presses 'search' button
  def create
    @book = Book.find_or_search_by(params[:title])
    redirect_to @book
  end

  # add the chosen book id to the session 
  # identify the club so the meeting can be associated to it
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

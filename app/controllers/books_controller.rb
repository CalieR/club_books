class BooksController < ApplicationController

  def new
  end

  def create
    book = Book.find_or_search_by(params[:title])
    byebug
  end
end

class Book < ApplicationRecord
  require 'json'
  require 'rest-client'

  has_many :meetings
  has_many :clubs, through: :meetings
  has_many :reviews, through: :meetings

  def self.find_or_search_by(title)
    book = Book.find_by(title: title)
    book ? book : get_book(title)
  end

  def self.get_book(title)
    book_data = search_api(title)

    book_title = get_book_title(book_data)
    book = Book.find_by(title: book_title)
    if book
      book
    else
      book_author = get_book_author(book_data)
      book_description = get_book_description(book_data)
      book_image = get_book_thumbnail(book_data)

      Book.create(title: book_title, author: book_author, description: book_description, image_url: book_image)
    end
  end

  def self.get_book_title(book_data)
    book_data["volumeInfo"]["title"]
  end

  def self.get_book_author(book_data)
    book_data["volumeInfo"]["authors"].join(', ')
  end

  def self.get_book_description(book_data)
    if book_data["volumeInfo"]["description"]
      book_data["volumeInfo"]["description"]
    else
      "Not available."
    end
  end

  def self.get_book_thumbnail(book_data)
    if book_data["volumeInfo"]["imageLinks"]["thumbnail"]
      book_data["volumeInfo"]["imageLinks"]["thumbnail"]
    else
      nil
    end
  end

  def self.search_api(title)
    response = RestClient.get("https://www.googleapis.com/books/v1/volumes?q=#{title}")
    data = JSON.parse(response)
    data["items"][0]
  end
end

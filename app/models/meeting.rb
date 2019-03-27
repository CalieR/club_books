class Meeting < ApplicationRecord
  belongs_to :book
  belongs_to :club
  has_many :reviews
end

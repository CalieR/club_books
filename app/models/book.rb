class Book < ApplicationRecord
    has_many :meetings
    has_many :clubs, through: :meetings
    has_many :reviews, through: :meetings
end

class Book < ApplicationRecord
    has_many :meetings
    has_many :clubs, through: :meetings
end

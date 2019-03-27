class Review < ApplicationRecord
  belongs_to :user
  belongs_to :meeting

  validates :rating, numericality: {greater_than: 0, less_than_or_equal_to: 10}
end

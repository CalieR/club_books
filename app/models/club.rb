class Club < ApplicationRecord
    has_many :memberships, dependent: :destroy 
    has_many :users, through: :memberships 
    has_many :meetings, dependent: :destroy
    has_many :books, through: :meetings
end

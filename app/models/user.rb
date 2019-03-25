class User < ApplicationRecord
    has_many :memberships
    has_many :clubs, through: :memberships

    validates :name, uniqueness: true
end

class User < ApplicationRecord
    has_many :memberships
    has_many :clubs, through: :memberships
    has_many :reviews
    has_many :meetings, through: :reviews
    has_many :books, through: :meetings

    validates :name, uniqueness: true

    def next_meetings
      self.clubs.map(&:next_meeting).compact
    end
end

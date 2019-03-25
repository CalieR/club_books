class User < ApplicationRecord
    has_many :memberships
    has_many :clubs, through: :memberships

    validates :name, uniqueness: true

    def next_meetings
      self.clubs.map(&:next_meeting)
    end
end

class Club < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    has_many :meetings, dependent: :destroy
    has_many :books, through: :meetings

    def next_meeting
      self.meetings.find_by(current: true)
    end

    def next_book 
      next_meeting ? next_meeting.book : nil
    end

    def admin 
      self.memberships.find_by(admin: true).user
    end

    def host 
      self.memberships.find_by(host: true).user
    end

    def standard_members 
      self.memberships.where(admin: false, host: false).map(&:user)
    end
end

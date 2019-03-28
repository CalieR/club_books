class Club < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    has_many :meetings, dependent: :destroy
    has_many :books, through: :meetings

    validates :name, presence: true

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
      host_member = self.memberships.find_by(host: true)
      host_member ? host_member.user : User.new
    end

    def standard_members
      self.memberships.where(admin: false, host: false).map(&:user)
    end

    def first_user=(user)
      self.memberships.create(user_id: user.id, admin: true, host: true)
    end

    def nil_host
      self.memberships.find_by(host: true).update(host: false)
    end

    def host_id=(user_id)
      new_host = self.memberships.find_by(user_id: user_id)
      new_host.update(host: true)
    end

    def host_id
      host ? host.id : User.new.id
    end
end

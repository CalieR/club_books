class Club < ApplicationRecord
    has_many :memberships, dependent: :destroy
    has_many :users, through: :memberships
    has_many :meetings, dependent: :destroy
    has_many :books, through: :meetings

      # a club must have a name
    validates :name, presence: true

    # only one meeting per club at a time will have its current attribute set to true
    def next_meeting
      self.meetings.find_by(current: true)
    end

      # if there is a next meeting return its book
    def next_book
      next_meeting ? next_meeting.book : nil
    end

      # one user is the admin, this never changes
    def admin
      self.memberships.find_by(admin: true).user
    end
 
    def host
      host_member = self.memberships.find_by(host: true)
      host_member ? host_member.user : User.new
    end

      # users who are not hosts or admins
    def standard_members
      self.memberships.where(admin: false, host: false).map(&:user)
    end

      # automatically set user as the admin and first host when they create a new club
    def first_user=(user)
      self.memberships.create(user_id: user.id, admin: true, host: true)
    end

      # find the current host user and remove host privileges
    def nil_host
      self.memberships.find_by(host: true).update(host: false)
    end

      # set a user as the new host of a club
    def host_id=(user_id)
      new_host = self.memberships.find_by(user_id: user_id)
      new_host.update(host: true)
    end

      # required to populate the collection_select dropdown in the form for choosing a new host
    def host_id
      host.id 
    end
end

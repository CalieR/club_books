class User < ApplicationRecord
    has_many :memberships
    has_many :clubs, through: :memberships
    has_many :reviews
    has_many :meetings, through: :reviews
    has_many :books, through: :meetings

      # users cannot share the same name
    validates :name, uniqueness: true


      # for this user, look at each of their clubs and get the next meeting for each, then use compact to remove any nil values (ie that club didn't have a next meeting)
      # & calls 'to_proc' on :next_meeting attribute, this converts it to a method which can then be called on self.clubs 
    def next_meetings
      self.clubs.map(&:next_meeting).compact
    end
    
end

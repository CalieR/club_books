class MeetingsController < ApplicationController
  # user must be logged in to create a meeting
  before_action :require_login

    def new
      @user = User.find(session[:user_id])
      @club = Club.find(params[:club_id])
      @book = Book.find(session[:book_id])
      @meeting = Meeting.new
    end

      # merge needed to join params from nested routes
      # don't need to keep the chosen book in cookies once the meeting is set
      # we haven't set any validations on this yet
    def create
      meeting = Meeting.create(meeting_params.merge(club_id: params[:club_id]))
      if meeting.valid?
        session[:book_id] = nil
        redirect_to meeting.club
      else
        @club = club.find(params[:club_id])
        redirect_to new_club_meeting_path(@club)
      end
    end

    def edit
      @meeting = Meeting.find(params[:id])
    end

    def update
      meeting = Meeting.find(params[:id])
      meeting.update(meeting_params)
      unless meeting.current
        meeting.club.nil_host
      end
      redirect_to meeting.club
    end

    def destroy
      meeting = Meeting.find(params[:id])
      club = meeting.club
      meeting.destroy
      redirect_to club
    end

    private

    def meeting_params
      params.require(:meeting).permit(:book_id, :date_time, :location, :current)
    end

    def require_login
      authorised?
    end
end

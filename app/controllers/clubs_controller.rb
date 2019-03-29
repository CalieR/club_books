class ClubsController < ApplicationController
  
  # correct club must be identified (unless creating a new one)
  before_action :set_club, only: [:edit, :update, :show]
  # before user can do anything they must be logged in (authorised)
  before_action :require_login

  def index
      @clubs = Club.all
  end

  # user must be authorised for any club they wish to look at
  def show
    @users = @club.users
    @user = current_user
    authorised_for_clubs
    session[:club_id] = @club.id
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.create(club_params(:name, :description))
    if @club.valid?
      @club.first_user = current_user
      redirect_to @club
    else
      redirect_to new_club_path
    end
  end

  def edit
  end

  def update
    @club.update(club_params(:description, :host_id))
    redirect_to @club
  end

  private

  # different params can be permitted depending on the action required
  def club_params(*args)
    params.require(:club).permit(args)
  end

  def set_club
    @club = Club.find(params[:id])
  end

  def require_login
    authorised?
  end
end

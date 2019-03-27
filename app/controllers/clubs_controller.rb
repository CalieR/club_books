class ClubsController < ApplicationController
  before_action :set_club, only: [:edit, :show]
  before_action :require_login

  def index
      @clubs = Club.all
  end

  def show
    @users = @club.users
    @user = current_user
    authorised_for_clubs
  end

  def new
    @club = Club.new
  end

  def create
    @club = Club.create(club_params(:name, :description))
    @club.first_user = current_user
    redirect_to @club
  end

  def edit
  end

  def update
    @club.update(club_params(:description, :host_id))
    redirect_to @club
  end

  private

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

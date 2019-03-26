class ClubsController < ApplicationController

  def index
      @user = User.find(session[:user_id])
      @clubs = Club.all
  end

  def show
    @user = User.find(session[:user_id])
    @club = Club.find(params[:id])
    @users = @club.users
    redirect_to @user unless @user.club_ids.include?(@club.id)
  end

  def new
    @club = Club.new
  end

  def create
    @user = User.find(session[:user_id])
    @club = Club.create(club_params(:name, :description))
    @club.first_user = @user
    redirect_to @club
  end

  def edit
    @club = Club.find(params[:id])
  end

  def update
    @club = Club.find(params[:id])
    @club.update(club_params(:description, :host_id))
    redirect_to @club
  end

  private

  def club_params(*args)
    params.require(:club).permit(args)
  end

end

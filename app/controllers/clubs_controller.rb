class ClubsController < ApplicationController

  def index
      @user = User.find(session[:user_id])
      @clubs = Club.all
  end

  def show
      @user = User.find(session[:user_id])
      @club = Club.find(params[:id])
      redirect_to @user unless @user.club_ids.include?(@club.id)
  end

  def new
    @club = Club.new
  end

  def create
    @user = User.find(session[:user_id])
    @club = Club.create(club_params)
    @club.first_user = @user
    redirect_to @club
  end

  private

  def club_params
    params.require(:club).permit(:name, :description)
  end

end

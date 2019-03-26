class MembershipsController < ApplicationController
  def create
    @user = User.find(session[:user_id])
    @club = Club.find(params[:membership][:club_id])
    @club.users << @user
    redirect_to @club
  end
end

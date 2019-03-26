class ClubsController < ApplicationController

    def index 
        @clubs = Club.all
    end

    def show 
        @user = User.find(session[:user_id])
        @club = Club.find(params[:id])
        redirect_to @user unless @user.club_ids.include?(@club.id)
    end

   
end

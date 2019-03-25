class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_or_create_by(name: params[:name])
    session[:user_id] = @user.id
    redirect_to @user
  end

  def destroy
    sessions.delete :name
  end

end

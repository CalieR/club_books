class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_name(params[:name])
    if @user
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = 'User not found'
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to login_path
  end

end

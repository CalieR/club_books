class SessionsController < ApplicationController
  def new
  end

  # add an existing user id to a session
  # or prompt to create a profile 
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

  # clear user id from session (log out)
  def destroy
    session.delete :user_id
    redirect_to login_path
  end

end

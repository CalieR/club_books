class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :destroy]
  before_action :require_login

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def destroy
    @user.destroy
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def require_login
    authorised?
  end

  # def set_user
  #   @user = User.find(session[:user_id])
  # end
end

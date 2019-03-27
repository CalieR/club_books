class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      User.new
    end
  end

  def logged_in?
      !!current_user.id
  end

  def  authorised?
      if !logged_in?
          flash[:errors] = ["you are not logged in"]
          redirect_to login_path and return 
      end
  end

  def authorised_for_user(target_user_id)
    if current_user.id != target_user_id.to_i
      flash[:errors] = ["You cannot view a page that does not belong to you"]
      redirect_to current_user
    end
  end

  def authorised_for_clubs
      if current_user.club_ids.exclude?(@club.id)
          flash[:errors] = ["You cannot view a page that does not belong to you"]
          redirect_to current_user
      end
  end
end

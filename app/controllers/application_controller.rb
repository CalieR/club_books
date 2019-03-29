class ApplicationController < ActionController::Base
  # this line makes current_user available to all the controllers and views
  helper_method :current_user

    # load existing user or create new instance
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    else
      User.new
    end
  end

    # current_user.id ? true : false
  def logged_in?
      !!current_user.id
  end
 
  def  authorised?
      if !logged_in?
          flash[:errors] = ["you are not logged in"]
          redirect_to login_path and return 
      end
  end

  # checks the id of the user logged in matches the id (from params) of the user page they are trying to access 
  def authorised_for_user(target_user_id)
    if current_user.id != target_user_id.to_i
      flash[:errors] = ["You cannot view a page that does not belong to you"]
      redirect_to current_user
    end
  end

    # checks the user logged in has a club_id that matches the id (from params) of the club page they are trying to access 
  def authorised_for_clubs
      if current_user.club_ids.exclude?(@club.id)
          flash[:errors] = ["You cannot view a page that does not belong to you"]
          redirect_to current_user
      end
  end
end

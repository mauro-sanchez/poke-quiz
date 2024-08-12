class ApplicationController < ActionController::Base
  before_action :is_not_logged
  helper_method :get_current_user

  ##
  # The function `is_not_logged` redirects to the new session path if the user is not logged in. (While accessing restricted pages)
  def is_not_logged
    redirect_to new_session_path unless session.include? :user_id
  end

  ##
  # The function `is_logged` redirects to the root path if a user is logged in based on the presence
  # of a `:user_id` key in the session. (While accessing to login or new user pages)
  def is_logged
    redirect_to root_path if session.include? :user_id
  end

  # obtain user data if needed
  def get_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

class ApplicationController < ActionController::Base
  before_action :is_not_logged
  helper_method :get_current_user

  def is_not_logged
    redirect_to new_session_path unless session.include? :user_id
  end

  def is_logged
    redirect_to root_path if session.include? :user_id
  end

  def get_current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

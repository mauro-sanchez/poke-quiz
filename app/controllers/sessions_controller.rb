class SessionsController < ApplicationController
  skip_before_action :is_not_logged, only: %i[create new]
  before_action :is_logged, only: %i[create new]

  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email])
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to new_quiz_path
    else
      flash[:notice] = 'Email/password is invalid!'
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out!'
    redirect_to new_session_path
  end
end

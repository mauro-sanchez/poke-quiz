class SessionsController < ApplicationController
  skip_before_action :is_not_logged, only: %i[create new]
  before_action :is_logged, only: %i[create new]

  ##
  # The `create` function handles user authentication by checking the email and password provided in
  # the session parameters.
  def create
    session_params = params.permit(:email, :password)
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to new_quiz_path
    else
      flash[:notice] = 'Email/password is invalid!'
      redirect_to new_session_path
    end
  end

  ##
  # The `destroy` function signs out the user, clears the user session, displays a signed out message,
  # and redirects to the root path.
  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Signed out!'
    redirect_to root_path
  end
end

class UsersController < ApplicationController
  skip_before_action :is_not_logged
  before_action :is_logged, only: %i[create new]

  def new
    @user = User.new
  end

  ##
  # The `create` function creates a new user, sets the session user ID if the user is valid, and
  # redirects with success or error messages accordingly.
  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to new_quiz_path, flash: { success: 'Account created!' }
    else
      redirect_to new_user_path, flash: { error: @user.errors.objects.first.full_message }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end

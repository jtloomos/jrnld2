class UsersController < ApplicationController
  def show
    @user = current_user
    authorize @user
  end

  def update
    @user = current_user
    authorize @user
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def dashboard
    @user = current_user
    authorize @user
  end

  def preferences
  end

  def analytics
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birthday, :gender)
  end
end

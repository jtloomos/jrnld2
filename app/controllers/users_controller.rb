class UsersController < ApplicationController

  def show
    @user = current_user
    authorize @user
    @notifications = ["Daily", "Once a week", "Once a month", "Never"]
  end

  def update
    @user = current_user
    authorize @user
    @notifications = ["Daily", "Once a week", "Once a month", "Never"]
    if params[:user]["old_password"].nil? && params[:user]["password"].nil?
      @user.update(user_params)
      redirect_to user_path(current_user)
    else
      if current_user.valid_password?(params[:user]["old_password"])
        current_user.update(password: params[:user]["password"])
        flash[:notice] = "Your password has been updated!"
        redirect_to new_user_session_path
      else
        render :show
      end
    end
  end

  def dashboard
    @user = current_user
    authorize @user
  end

  def preferences
  end

  def analytics
  end

  def destroy
    @user = current_user
    authorize @user
    @user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birthday, :gender, :notifications)
  end
end

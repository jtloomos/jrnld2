class UsersController < ApplicationController
  def show
    @user = current_user
    authorize @user
  end

  def update
  end

  def dashboard
    @user = current_user
    authorize @user
  end

  def preferences
  end

  def analytics
  end
end

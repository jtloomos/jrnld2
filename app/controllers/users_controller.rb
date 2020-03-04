class UsersController < ApplicationController
  def show
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

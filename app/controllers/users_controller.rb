class UsersController < ApplicationController
  before_action :authorize_user, only: [:dashboard, :preferences]

  def show
  end

  def update
  end

  def dashboard
  end

  def preferences
    @reminder = Reminder.new
  end

  def analytics
  end

  private

  def authorize_user
    @user = current_user
    authorize @user
  end
end

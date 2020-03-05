class UsersController < ApplicationController
  before_action :authorize_user, only: [:dashboard, :preferences, :new_preferences]

  def show
    @user = current_user
    authorize @user
  end

  def update
  end

  def dashboard
  end

  def preferences
    @user_reminders = Reminder.where(user: current_user).map { |r| r.title.upcase}
    @reminders = %w[SPORTS FAMILY FRIENDS SPECIAL ONE] + @user_reminders
    @notifications = ["Twice a day", "Once a day", "Once a week", "Never"]
    @reminder = Reminder.new

  end

  def new_preferences
    raise
  end

  def analytics
  end

  private

  def authorize_user
    @user = current_user
    authorize @user
  end
end

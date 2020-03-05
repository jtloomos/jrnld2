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
    @default_reminders = %w[SPORTS FAMILY FRIENDS SPECIAL ONE]
    @reminder = Reminder.new
  end

  def new_preferences
    user_reminders = Reminder.where(user_id: current_user.id).pluck(:title)
    reminders = params.select {|key, value| key =~ /reminder-\d/ }

    user_reminders.each do |user_reminder|
      db_reminder = Reminder.find_by(title: user_reminder)
      db_reminder.destroy unless reminders.values.include?(user_reminder) || !db_reminder
    end

    reminders.each do |key,reminder|
      Reminder.create(title: reminder, user: current_user) unless user_reminders.include?(reminder)
    end

    redirect_to
  end

  def analytics
  end

  private

  def authorize_user
    @user = current_user
    authorize @user
  end
end

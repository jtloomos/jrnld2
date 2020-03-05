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
    @user_reminders = Reminder.where(user: current_user)
    @default_reminders = Reminder.where(user: nil)
    @reminder = Reminder.new
  end

  def new_preferences
    user_reminders = Reminder.where(user_id: current_user.id)
    reminders = params.select {|key, value| key =~ /reminder-\d/ }.values

    user_reminders.each do |user_reminder|
      user_reminder.destroy unless reminders.include?(user_reminder.title)
    end

    reminders.each do |reminder|
      Reminder.create(title: reminder, user: current_user) unless user_reminders.pluck(:title).include?(reminder)
    end

    redirect_to dashboard_path
  end

  def analytics
  end

  private

  def authorize_user
    @user = current_user
    authorize @user
  end
end

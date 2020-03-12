class UsersController < ApplicationController
  before_action :authorize_user, only: [:dashboard, :preferences, :new_preferences]

  def show
    @user = current_user
    authorize @user
    @notifications = ["Daily", "Once a week", "Once a month", "Never"]
    @user_reminders = Reminder.where(user: current_user)
    @default_reminders = Reminder.where(user: nil)
  end

  def update
    @user = User.find(params[:id])
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
  end

  def preferences
    @user_reminders = Reminder.where(user: current_user)
    @default_reminders = Reminder.where(user: nil)
  end

  def new_preferences
    user_reminders = Reminder.where(user_id: current_user.id)
    reminders = params.select {|key, value| key =~ /reminder-.+/ }.values

    user_reminders.each do |user_reminder|
      user_reminder.destroy unless reminders.include?(user_reminder.title)
    end

    reminders.each do |reminder|
      Reminder.create(title: reminder, user: current_user) unless user_reminders.pluck(:title).include?(reminder)
    end

    redirect_to dashboard_path
  end

  def analytics
    @user = current_user
    authorize @user


    all_entries = []
    # Entry.select...
    @user.entries.includes(:analytic).each do |entry|
      entry_array = []
      entry_array << entry.country_code
      entry_array << entry.analytic.word_count
      all_entries << entry_array
    end


    entries_hash = all_entries.each_with_object(Hash.new(0)) do |(key, value), hash|
      hash[key] += value
    end

    @region = [['Country', 'Words']]
    entries_hash.each { |key, value| @region << [key, value] }

    @region.to_json

    @data = @user.common_words.map {|key, value| { 'x': key, 'value': value } }
  end

  def destroy
    @user = User.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to root_path
  end

  private

  def authorize_user
    @user = current_user
    authorize @user
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :birthday, :gender, :photo, :notifications)
  end
end

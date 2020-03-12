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

    # WORD CLOUD
    @data = @user.common_words.map {|key, value| { 'x': key, 'value': value } }

    # ENTRIES COUNT MAP
    all_entries = []
    @user.entries.map do |entry|
      entry_array = []
      entry_array << entry.country_code
      entry_array << 1

      all_entries << entry_array
    end


    entries_hash = all_entries.each_with_object(Hash.new(0)) do |(key, value), hash|
      hash[key] += value
    end
    @region_entries = [['Country', 'Entries']]
    entries_hash.each { |key, value| @region_entries << [key, value] }
    @region_entries.to_json

    # WORD COUNT MAP
    all_words = []
    @user.entries.map do |entry|
      words_array = []
      words_array << entry.country
      words_array << entry.analytic.word_count
      all_words << words_array
    end
    words_hash = all_words.each_with_object(Hash.new(0)) do |(key, value), hash|
      hash[key] += value
    end
    @region_words = [['Country', 'Words']]
    words_hash.each { |key, value| @region_words << [key, value] }
    @region_words.to_json

    # TIME SPENT MAP
    all_times = []
    @user.entries.map do |entry|
      times_array = []
      times_array << entry.country
      times_array << entry.analytic.time_spent
      all_times << times_array
    end
    times_hash = all_times.each_with_object(Hash.new(0)) do |(key, value), hash|
      hash[key] += value
    end
    @region_times = [['Country', 'Time spent']]
    times_hash.each { |key, value| @region_times << [key, value] }
    @region_times.to_json


    # ENTRIES GRAPH
    @entries_count = Hash.new
    User.joins(:entries).select("COUNT(entries.created_at_day), entries.created_at_day").where(users: { id: current_user.id }).group("entries.created_at_day").each {|r| @entries_count[r.created_at_day] = r.count }

    # WORD COUNT GRAPH
    @word_count = Hash.new
    User.joins(entries: :analytic).select("SUM(analytics.word_count), entries.created_at_day").where(users: { id: current_user.id }).group("entries.created_at_day").each {|r| @word_count[r.created_at_day] = r.sum }

    # TIME SPENT GRAPH
    @time_spent = Hash.new
    User.joins(entries: :analytic).select("SUM(analytics.time_spent), entries.created_at_day").where(users: { id: current_user.id }).group("entries.created_at_day").each {|r| @time_spent[r.created_at_day] = r.sum }
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

class EntriesController < ApplicationController
  def index
    @entries = policy_scope(Entry)
    @user = current_user
  end

  def show
  end

  def new
    @entry = Entry.new
    authorize @entry

    @reminders = Reminder.where(user_id: current_user.id)
  end

  def create
    # @entry_tag = EntryTag.create!(tag: @tag, entry: @entry)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

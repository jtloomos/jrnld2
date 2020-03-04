class EntriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search].present? && params[:search][:query].present?
      sql_query = "content ILIKE :query"
      @query = params[:search][:query]
      @entries = policy_scope(Entry).where(sql_query, query: "%#{params[:search][:query]}%")
    else
      @entries = policy_scope(Entry)
    end

    @user = current_user

    @markers = @entries.map do |entry|
      {
        lat: entry.latitude,
        lng: entry.longitude
      }
    end
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

class EntriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:search].present? && params[:search][:query].present?
      sql_query = "content ILIKE :query OR tags.title ILIKE :query"
      @query = params[:search][:query]
      @entries = policy_scope(Entry).joins(tags: :entry_tags).where(sql_query, query: "%#{params[:search][:query]}%").distinct
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

  def map
     if params[:search].present? && params[:search][:location].present?
      sql_query = "location ILIKE :query"
      @query = params[:search][:location]
      @entries = policy_scope(Entry).near(params[:search][:location], 100)
      authorize @entries
    else
      @entries = policy_scope(Entry)
      authorize @entries
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
    @entry = Entry.new(entry_params)
    authorize @entry
    @entry.user = current_user
    @entry.save!

    params[:entry][:tag_ids].each do |id|
      if id.match?(/\A\d+\z/) # if id is a number (current_user.tags exists)
        @entry_tag = EntryTag.create!(tag_id: id, entry: @entry)
        # WHAT IF user enters a number as a custom/new tag though?? FOCKKKK
      elsif id.match?(/\A(tag_).+\z/) # if id is an integer number (current_user.tags does not exist)
        @gsub = id.gsub(/(tag_)/, "")
        @tag = Tag.create!(title: @gsub)
        @entry_tag = EntryTag.create!(tag: @tag, entry: @entry)
      elsif id.match?(/\A.+\z/) # if id is text (current_user.tags does not exist)
        @tag = Tag.create!(title: id)
        @entry_tag = EntryTag.create!(tag: @tag, entry: @entry)
      else
        # if params passes an empty id, do nothing
      end
    end
    redirect_to entries_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :location)
  end
end

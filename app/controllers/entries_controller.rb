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

    # entry_tag_params should be a hash containing all ids in an array, as a value??
    # e.g { tag_ids: [ '1', '2', 'test' ]}
    # entry_tag_params[:tag_ids].each do |id|
    params[:entry][:tag_ids].each do |id|
      if id.match?(/\A\d+\z/) # if id is a number (tag exists)
        @entry_tag = EntryTag.create!(tag_id: id, entry: @entry) # CONFIRMED TO WORK NOW!
        # WHAT IF user enters a number as a custom/new tag though?? FOCKKKK
      elsif id.match?(/\A(btn-reminder-).+\z/) # if id is btn-reminder-<id> (added via reminders)
        @gsub = id.gsub(/btn-reminder-/, "") # create an entry_tag grabbing this id
        @entry_tag = EntryTag.create!(tag_id: @gsub, entry: @entry)
      elsif id.match?(/\A.+\z/) # if id is the text of the custom/new tag - CONFIRMED TO WORK NOW!
        @tag = Tag.create!(title: id) # create a new tag with said text
        @entry_tag = EntryTag.create!(tag: @tag, entry: @entry) # create an entry_tag via new tag
      else # if id is empty
        # do nothing
      end
    end

    raise

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

  # def entry_tag_params
  #   params.require(:entry).permit(:tag_ids)
  # end
end

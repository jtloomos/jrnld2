require "date"

class EntriesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    start_date, end_date = params[:search][:date_range].split(" to ") if params.dig(:search, :date_range)

    if end_date.nil?
      end_date = start_date
    end

    sql_query = "entries.title ILIKE :query OR content ILIKE :query OR tags.title ILIKE :query OR location ILIKE :query"
    @query = params[:search][:query] if params.dig(:search, :query)
    @entries = policy_scope(Entry)
    @entries = @entries.left_outer_joins(tags: :entry_tags).where(sql_query, query: "%#{params[:search][:query]}%").distinct if params.dig(:search, :query)
    @entries = @entries.where(:created_at => start_date.to_date.beginning_of_day..end_date.to_date.end_of_day) if start_date && end_date
    @user = current_user
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
      lng: entry.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { entry: entry }),
      image_url: helpers.asset_url("pin.png")
    }
    end
  end

  def show
    @entry = Entry.find(params[:id])
    authorize @entry
    @analytic = @entry.analytic

    @markers =[
      {
        lat: @entry.latitude,
        lng: @entry.longitude,
        image_url: helpers.asset_url("pin.png")
      }]

      @data = @entry.analytic.word_frequencies.map {|element| { 'x': element.word, 'value': element.frequency } }
    end


    def new
      @entry = Entry.new(start_entry: Time.now, created_at_day: Date.today)
      authorize @entry
      @reminders = Reminder.where(user_id: current_user.id)
    end

    def create
      @entry = Entry.new(entry_params)
      authorize @entry
      @entry.user = current_user
      @entry.start_entry = params["entry"]["start_entry"]

      if @entry.save
         AnalyticJob.perform_now(self.id)

        create_entry_tags
        redirect_to entries_path
      else
        @reminders = Reminder.where(user_id: current_user.id)
        render :new
      end
    end

    def edit
      @entry = Entry.find(params[:id])
      authorize @entry
      @reminders = Reminder.where(user_id: current_user.id)
    end

    def update
      @entry = Entry.find(params[:id])
      authorize @entry

      if @entry.update(entry_params)
        AnalyticJob.perform_now(self.id)

        create_entry_tags
        redirect_to entry_path(@entry)
      else
        @reminders = Reminder.where(user_id: current_user.id)
        render :edit
      end
    end

    def destroy
      @entry = Entry.find(params[:id])
      authorize @entry
      @entry.destroy

      redirect_to entries_path
    end

    private


  def entry_params
    params.require(:entry).permit(:title, :content, :location, :emoji, :created_at_day, photos: [])
  end


    def create_entry_tags
      @entry.entry_tags.destroy_all
      params[:entry][:tag_ids].each do |id|
        if id.match?(/\A\d+\z/) && @entry.tags.pluck("id").include?(id.to_i)
        # if tag is already associated with this entry, do nothing
      elsif id.match?(/\A\d+\z/) # if id is a number (current_user.tags exists)
        @entry_tag = EntryTag.create!(tag_id: id, entry: @entry)
      elsif id.match?(/\A(tag_).+\z/) # if id title is a number and current_user.tags does not exist
        @gsub = id.gsub(/(tag_)/, "").upcase
        @tag = Tag.create!(title: @gsub)
        @entry_tag = EntryTag.create!(tag: @tag, entry: @entry)
      elsif id.match?(/\A.+\z/) # if id is text and current_user.tags does not exist
        @tag = Tag.create!(title: id.upcase)
        @entry_tag = EntryTag.create!(tag: @tag, entry: @entry)
      else
        # if params passes an empty id, do nothing
      end
    end
  end
end

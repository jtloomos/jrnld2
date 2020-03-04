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
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

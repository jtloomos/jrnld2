class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :contact, :homepage]

  def home
  end

  def contact
  end

  def homepage
  end
end

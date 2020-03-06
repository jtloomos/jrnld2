class RemindersController < ApplicationController
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    @reminder.title.upcase!
    @reminder.save
    authorize @reminder

    respond_to do |format|
      format.html {redirect_to preferences_path}
      format.js
    end
  end

  def update
  end

  private

  def reminder_params
    params.require(:reminder).permit(:title)
  end
end

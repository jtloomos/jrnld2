class RemindersController < ApplicationController
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    @reminder.save
    authorize @reminder
    redirect_to preferences_path
  end

  def update
  end

  private

  def reminder_params
    params.require(:reminder).permit(:title)
  end
end

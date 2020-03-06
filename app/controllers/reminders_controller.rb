class RemindersController < ApplicationController
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    @reminder.title.upcase!
    authorize @reminder
    @reminder.save
  end

  def update
  end

  private

  def reminder_params
    params.require(:reminder).permit(:title)
  end
end

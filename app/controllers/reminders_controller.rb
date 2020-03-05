class RemindersController < ApplicationController
  def create
    @reminder = Reminder.create(reminder_params)
    authorize @reminder
  end

  def update
  end

  private

  def reminder_params
    params.require(:reminder).permit(:title, :user_id)
  end
end

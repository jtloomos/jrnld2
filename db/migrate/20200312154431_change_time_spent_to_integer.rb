class ChangeTimeSpentToInteger < ActiveRecord::Migration[5.2]
  def change
    remove_column :analytics, :time_spent
    add_column :analytics, :time_spent, :integer
  end
end

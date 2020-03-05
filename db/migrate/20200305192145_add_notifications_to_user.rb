class AddNotificationsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :notifications, :string
  end
end

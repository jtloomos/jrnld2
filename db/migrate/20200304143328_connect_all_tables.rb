class ConnectAllTables < ActiveRecord::Migration[5.2]
  def change
    add_reference :reminders, :user, foreign_key: true

    add_reference :entries, :user, foreign_key: true

    add_reference :entry_tags, :entry, foreign_key: true
    add_reference :entry_tags, :tag, foreign_key: true
  end
end

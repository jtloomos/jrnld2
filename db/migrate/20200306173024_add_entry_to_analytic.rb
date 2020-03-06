class AddEntryToAnalytic < ActiveRecord::Migration[5.2]
  def change
    add_reference :analytics, :entry, foreign_key: true
  end
end

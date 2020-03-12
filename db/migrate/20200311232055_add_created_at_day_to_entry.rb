class AddCreatedAtDayToEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :created_at_day, :date
  end
end

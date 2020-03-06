class AddStartEntryToEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :start_entry, :datetime
  end
end

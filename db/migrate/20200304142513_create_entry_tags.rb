class CreateEntryTags < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_tags do |t|

      t.timestamps
    end
  end
end

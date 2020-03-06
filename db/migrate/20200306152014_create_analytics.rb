class CreateAnalytics < ActiveRecord::Migration[5.2]
  def change
    create_table :analytics do |t|
      t.integer :word_count
      t.string :time_spent
      t.string :emotion
      t.string :emoji
      t.string :location
      t.string :created_day
      t.string :created_time
      t.string :weather
      t.string :people

      t.timestamps
    end
  end
end

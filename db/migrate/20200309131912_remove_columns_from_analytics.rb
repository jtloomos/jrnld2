class RemoveColumnsFromAnalytics < ActiveRecord::Migration[5.2]
  def change
    remove_column :analytics, :people
    remove_column :analytics, :emotion
  end
end

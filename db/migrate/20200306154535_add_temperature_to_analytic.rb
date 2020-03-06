class AddTemperatureToAnalytic < ActiveRecord::Migration[5.2]
  def change
    add_column :analytics, :temperature, :integer
  end
end

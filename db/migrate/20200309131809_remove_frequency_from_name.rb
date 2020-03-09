class RemoveFrequencyFromName < ActiveRecord::Migration[5.2]
  def change
    remove_column :name_frequencies, :frequency
  end
end

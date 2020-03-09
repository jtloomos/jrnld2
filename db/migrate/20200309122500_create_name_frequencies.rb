class CreateNameFrequencies < ActiveRecord::Migration[5.2]
  def change
    create_table :name_frequencies do |t|
      t.string :name
      t.integer :frequency
      t.references :analytic, foreign_key: true

      t.timestamps
    end
  end
end

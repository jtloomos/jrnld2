class CreateWordFrequencies < ActiveRecord::Migration[5.2]
  def change
    create_table :word_frequencies do |t|
      t.string :word
      t.integer :frequency
      t.references :analytic, foreign_key: true

      t.timestamps
    end
  end
end

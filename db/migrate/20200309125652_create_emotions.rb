class CreateEmotions < ActiveRecord::Migration[5.2]
  def change
    create_table :emotions do |t|
      t.string :emotion
      t.integer :level
      t.references :analytic, foreign_key: true

      t.timestamps
    end
  end
end

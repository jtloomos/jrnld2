class AddEmojiToEntry < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :emoji, :string
  end
end

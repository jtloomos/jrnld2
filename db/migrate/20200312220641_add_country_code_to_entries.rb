class AddCountryCodeToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :country_code, :string
  end
end

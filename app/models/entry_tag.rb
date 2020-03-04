class EntryTag < ApplicationRecord
  belongs_to :entry
  belongs_to :tag

  validates_presence_of :entry, :tag
end

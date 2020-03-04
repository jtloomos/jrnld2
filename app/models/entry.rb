class Entry < ApplicationRecord
  belongs_to :user
  has_many :entry_tags

  validates_presence_of :title, :content, :user
end

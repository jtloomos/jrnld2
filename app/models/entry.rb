class Entry < ApplicationRecord
  belongs_to :user
  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates_presence_of :title, :content, :user

  geocoded_by :location
  after_validation :geocode
end

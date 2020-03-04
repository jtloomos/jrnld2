class Tag < ApplicationRecord
  has_many :entry_tags

  validates :title, presence: true
end

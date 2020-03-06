class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :analytic
  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates_presence_of :title, :content, :user

  geocoded_by :location
  after_validation :geocode

  after_commit :async_update # Run on create & update

  private

  def async_update
    AnalyticJob.perform_later(self.id)
  end
end

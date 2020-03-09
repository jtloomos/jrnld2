class Entry < ApplicationRecord
  belongs_to :user
  has_one :analytic
  has_many :entry_tags
  has_many :tags, through: :entry_tags

  validates_presence_of :title, :content, :user, :location
  validates :emoji, inclusion: { in: %w[angry sad ok good happy]}

  geocoded_by :location
  after_validation :geocode

  after_commit :async_update # Run on create & update

  def emotions_hash
    analytic.emotions.each_with_object({}) { | emotion, result |
      result[emotion.emotion] = emotion.level if emotion.level > 0
    }
  end

  def words_hash
    analytic.word_frequencies.each_with_object({}) { | word, result |
      result[word.word] = word.frequency
    }
  end

  private

  def async_update
    AnalyticJob.perform_later<(self.id)
  end
end

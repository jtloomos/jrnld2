class Entry < ApplicationRecord
  AVAILABLE_EMOJIS = %w[angry sad ok good happy]
  AVAILABLE_EMOTIONS = %w[happy excited fear sad bored angry]

  belongs_to :user
  has_one :analytic, dependent: :destroy
  has_many :entry_tags, dependent: :destroy
  has_many :tags, through: :entry_tags

  has_many_attached :photos

  validates_presence_of :title, :content, :user, :location
  validates :emoji, inclusion: { in: AVAILABLE_EMOJIS}

  geocoded_by :location
  after_validation :geocode

  default_scope { order(created_at: :desc) }

  def date
    self.created_at
  end

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
end

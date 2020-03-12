require "date"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :reminders
  has_many :entries
  has_many :analytics, through: :entries
  has_many :entry_tags, through: :entries

  validates_presence_of :username, :first_name, :last_name, :birthday, :gender
  validates :username, uniqueness: true

  has_one_attached :photo

  def tags
    self.entry_tags.map do |entry_tag|
      entry_tag.tag
    end
  end

  def emojies
    self.entries.map { |entry| entry.emoji }.uniq
  end

  def mood_average(mood, emoji = nil)
    first_array = emoji ? self.analytics.where(emoji: emoji) : self.analytics
    array_of_mood = first_array.map do |analytic|
      analytic.emotions.select { |emotion| emotion.emotion == mood.downcase }.first
    end
    sum = 0
    array_of_mood.each do |emotion|
      sum += emotion.level
    end
    sum.to_f / first_array.size #returns the average level of the selected mood, looking through all the users entries.
  end

  def word_average(emoji = nil)
    first_array = emoji ? Entry.where(user: self, emoji: emoji) : Entry.where(user: self)
    sum = 0
    first_array.each do |entry|
      sum += entry.analytic.word_count
    end
    sum.to_f / first_array.size #returns average amount of words per entry
  end

  def temp_average(emoji = nil)
    first_array = emoji ? Entry.where(user: self, emoji: emoji) : Entry.where(user: self)
    sum = 0
    first_array.each do |entry|
      sum += entry.analytic.temperature
    end
    sum.to_f / first_array.size #returns average temperature per entry
  end

  def time_average(emoji = nil)
    first_array = emoji ? Entry.where(user: self, emoji: emoji) : Entry.where(user: self)
    sum = 0
    first_array.each do |entry|
      sum += entry.analytic.time_spent.to_f
    end
    sum.to_f / first_array.size #returns average time spent per entry
  end

  def entrys_per_day_average
    days = (Date.today - self.entries.first.created_at.to_date)
    p days
    self.entries.size / days.to_f #returns amount of entrys per day in average (We may want to use it per week? just multiply by 7. Maybe also round it)
  end

  def emoji_count(emoji)
    entries = self.entries.select {|entry| entry.emoji == emoji}
    entries.first.nil? ? 0 : entries.size #returns amount of times an emoji appears in the users entrys
  end

  def common_words
    user_word_frequencies = self.analytics.flat_map do |analytic|
      analytic.word_frequencies
    end
    user_word_frequencies.each_with_object(Hash.new(0)) do |word_freq, res|
      res[word_freq.word] += word_freq.frequency
    end #THIS ONE RETURNS A HASH RIGHT NOW. IF WE WANT AN ARRAY JUST USE #to_a wich returns an array with little arrays [word, frequency]
  end

  def common_people
    user_name_frequencies = self.analytics.flat_map do |analytic|
      analytic.name_frequencies
    end
    user_name_frequencies.each_with_object(Hash.new(0)) do |name_freq, res|
      res[name_freq.name] += 1
    end #SAME THING THAT WITH COMMON WORDS
  end

  def day
    created_at.strftime("%a, %d %b %Y")
  end

  def correlation(x, y) # x and y need to be 2 arrays of the same size !!
    n = x.length

    sumx = x.inject(0) { |r,i| r + i }
    sumy = y.inject(0) { |r,i| r + i }

    sumxSq = x.inject(0) { |r,i| r + i**2 }
    sumySq = y.inject(0) { |r,i| r + i**2 }

    prods = []

    x.each_with_index { |this_x,i| prods << this_x*y[i] }

    pSum = prods.inject(0){ |r,i| r + i }

    # Calculate Pearson score
    num = pSum - (sumx * sumy / n)
    den=((sumxSq-(sumx ** 2) / n) * (sumySq - (sumy **2) / n)) ** 0.5

    den == 0 ? 0 : num / den
  end
end

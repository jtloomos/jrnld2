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

  def mood_average(mood)
    array_of_mood = self.analytics.map do |analytic|
      analytic.emotions.select { |emotion| emotion.emotion == mood }.first
    end
    sum = 0
    array_of_mood.each do |emotion|
      sum += emotion.level
    end
    sum.to_f / array_of_mood.size #returns the average level of the selected mood, looking through all the users entries.
  end

  def word_average
    sum = 0
    self.entries.each do |entry|
      sum += entry.analytic.word_count
    end
    sum.to_f / self.entries.size #returns average word per entry
  end

  def time_average
    entries = Entry.where(user: self)
    sum = 0
    self.entries.each do |entry|
      sum += entry.analytic.time_spent
    end
    sum.to_f / self.entries.size #returns average time spent per entry
  end

  def day_average
    days = (Date.today - self.entries.first.created_at.to_date)
    p days
    self.entries.size / days.to_f #returns amount of entrys per day in average (We may want to use it per week? just multiply by 7. Maybe also round it)
  end

  def emoji_count(emoji)
    entries = self.entries.select {|entry| entry.emoji == emoji}
    entries.first.nil? ? 0 : entries.size #returns amount of times an emoji appears in the users entrys
  end
end

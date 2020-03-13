# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Destroy old seeds"

EntryTag.destroy_all
WordFrequency.destroy_all
NameFrequency.destroy_all
Emotion.destroy_all
Analytic.destroy_all
Entry.destroy_all
Reminder.destroy_all
Tag.destroy_all
User.destroy_all

puts "Starting seeding process..."
################ USER SEED ################

user_seed = [
  { email: 'john@gmail.com',
    username: 'johnsmith',
    password: 12345678,
    gender: 'male',
    first_name: 'John',
    last_name: 'Smith',
    birthday: Date.new(1994,05,03)}
  # { email: 'jrnld@jrnld.com',
  #   username: 'jrnld',
  #   password: 12345678,
  #   gender: 'female',
  #   first_name: 'Janette',
  #   last_name: 'Kwon',
  #   birthday: Date.new(1992,02,05)},
  # { email: 'test@test.com',
  #   username: 'test',
  #   password: 12345678,
  #   gender: 'female',
  #   first_name: 'Emilie',
  #   last_name: 'Drop',
  #   birthday: Date.new(1994,04,13)}
]

user_seed.each do |user|
  @user = User.new(user)
  @user.save!
end

################ REMINDER SEED ################

reminder_seed = [
  { title: 'SPORTS' },
  { title: 'FAMILY' },
  { title: 'LOVE' },
  { title: 'WORK' },
  { title: 'HOME' },
  { user_id: User.first.id, title: 'FOOD' },
  { user_id: User.first.id, title: 'CULTURE' },
  { user_id: User.first.id, title: 'LOVE' },
  { user_id: User.first.id, title: 'WILDFIRE' },
  { user_id: User.first.id, title: 'ADVENTURE' },
  { user_id: User.first.id, title: 'BEER' },
  # { user_id: User.second.id, title: 'SCHOOL' },
  # { user_id: User.second.id, title: 'FRIENDS' },
  # { user_id: User.second.id, title: 'LOVE' },
  # { user_id: User.second.id, title: 'FASHION' },
  # { user_id: User.second.id, title: 'FOOTBALL' },
  # { user_id: User.third.id, title: 'EXCERCISE' },
  # { user_id: User.third.id, title: 'FOOD' },
  # { user_id: User.third.id, title: 'FAMILY' },
  # { user_id: User.third.id, title: 'PLAY' },
  # { user_id: User.third.id, title: 'BEAUTY' },
  # { user_id: User.third.id, title: 'LOVE' }
]

reminder_seed.each do |reminder|
  @reminder = Reminder.new(reminder)
  @reminder.save!
end

################ ENTRY SEED ################

locations = [
  ["Boston, United States",  "US"],
  ["Buenos Aires, Argentina", "AR"],
  ["Tokyo, Japan",  "JP"],
  ["Athens, Greece", "GR"],
  ["Buenos Aires, Argentina", "AR"],
  ["Rome, Italy",  "IT"],
  ["Vancouver, Canada", "CA"],
  ["Moscow, Russia",  "RU"],
  ["Melbourne, Australia", "AU"],
  ["Moscow, Russia",  "RU"],
  ["Cairo, EGYPT", "EG"],
  ["Panama City, Panama",  "PA"],
  ["Dublin, Ireland", "IR"],
  ["Paris, France",  "FR"],
  ["Mumbai, India", "IN"],
  ["Bangkok, Thailand",  "TH"],
  ["Cape Town, South Africa", "ZA"],
  ["Oslo, Norway",  "NO"],
  ["Beijing, China", "CN"],
  ["Lisbon, Portugal",  "PT"],
  ["Melbourne, Australia", "AU"],
  ["Brasilia, Brazil",  "BR"],
  ["Quito, Ecuador", "EC"],
  ["Chicago, United States",  "US"],
  ["Los Angeles, United States", "CA"],
  ["Athens, Greece",  "GR"],
  ["Nairobi, Kenya", "KE"]
]

weathers = [
  "sunny",
  "cloudy",
  "rainy"
]

people = [
  "John",
  "Carl",
  "Jeff",
  "Thomas"
  ]


((DateTime.now - 50.days)..Time.now).each do |date|
  entry = Entry.new
  entry.user = User.first
  entry.start_entry = date
  entry.created_at = date + rand(550).seconds
  entry.created_at_day = entry.created_at.to_date

  location = locations.sample

  entry.location = location.first
  entry.country_code = location.last

  entry.emoji = Entry::AVAILABLE_EMOJIS.sample
  entry.title = Faker::Book.title
  entry.content = rand(5..20).times.map { Faker::TvShows::Friends.quote }.join(" ")
  entry.save!

  analytic = Analytic.new
  analytic.entry = entry
  analytic.word_count = WordsCounted.count(entry.content).token_count

  WordsCounted.count(entry.content).token_frequency.first(30).each do |pair|
    word_freq = WordFrequency.find_or_initialize_by(analytic: analytic, word: pair[0])
    word_freq.frequency = pair[1]
    word_freq.save!
  end

  analytic.location = entry.location
  analytic.created_day = entry.created_at
  analytic.created_time = entry.created_at.hour
  if entry.start_entry.nil?
    analytic.time_spent = 0
  else
    analytic.time_spent = ((entry.created_at - entry.start_entry) / 60).to_s
  end
  analytic.emoji = entry.emoji
  analytic.weather = weathers.sample
  analytic.temperature = rand(10..80).to_s

  people.sample(3).each do |word|
    NameFrequency.find_or_initialize_by(analytic: analytic, name: word.capitalize).save!
  end

  counter = 10

  emotions_hash = Entry::AVAILABLE_EMOTIONS[0..-2].each_with_object(Hash.new(0)) do |emotion_name, emotions|
    emotions[emotion_name] = rand(100-emotions.values.sum)
  end

  emotions_hash[Entry::AVAILABLE_EMOTIONS.last] = 100 - emotions_hash.values.sum

  emotions_hash.each do  |emotion_name, level|
     emotion = Emotion.find_or_initialize_by(analytic: analytic, emotion: emotion_name.downcase)
     emotion.level = level
     emotion.save!
  end

  analytic.save!
  puts analytic
end

  # data[:emotion].each do |pair|
  #   @emotion = Emotion.find_or_initialize_by(analytic: @analytic, emotion: pair[0].downcase)
  #   @emotion.level = pair[1]*100
  #   @emotion.save!
  # end










################ TAG SEED ################

tag_seed = [
  { title: 'CAT' },
  { title: 'FOOD' },
  { title: 'CULTURE' },
  { title: 'LOVE' },
  { title: 'FOOTBALL' },
  { title: 'WILDFIRE' },
  { title: 'ADVENTURE' },
  { title: 'BEER' },
  { title: 'SCHOOL' },
  { title: 'FRIENDS' },
  { title: 'FASHION' },
  { title: 'FAMILY' },
  { title: 'VIDEO-GAMES' },
  { title: 'BEAUTY' },
  { title: 'CAREER' },
  { title: 'FLOWERS' },
  { title: 'OCEAN' },
  { title: 'FITNESS' },
  { title: 'BOYS' },
  { title: 'NATURE' }
]

tag_seed.each do |tag|
  @tag = Tag.new(tag)
  @tag.save!
end

################ ENTRY_TAG SEED ################

Entry.all.each do |entry|
  all_tags = Tag.all.to_a
  rand(3..6).times do
    sample_tag = all_tags.sample
    @entry_tag = EntryTag.create!(entry_id: entry.id, tag_id: sample_tag.id)
    all_tags.delete_at(all_tags.index(sample_tag))
  end
end

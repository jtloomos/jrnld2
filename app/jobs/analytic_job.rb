class AnalyticJob < ApplicationJob
  queue_as :default

  def perform(entry_id)
    entry = Entry.find(entry_id)
    location = entry.location
    created_day = entry.created_at
    created_time = entry.created_at.hour
    time_spent = ((entry.created_at - entry.start_entry) / 60).to_s
    emoji = entry.emoji
    data = EntryHelper::analyze(entry)
    # data = {
    #         word_count: 100,
    #         words: {"hello" => 5, "Emilie" => 3, "Sebas" => 10},
    #         emotion: "happy",
    #         weather: "sunny",
    #         temperature: "22",
    #         people: ["Anna", "James", "Kevin"]
    #        }
    @analytic = Analytic.find_or_initialize_by(entry_id: entry_id)
    @analytic.time_spent = time_spent,
    @analytic.created_day = created_day,
    @analytic.created_time = created_time,
    @analytic.emoji = emoji,
    @analytic.location = location,
    @analytic.word_count = data[:word_count],
    @analytic.weather = data[:weather],
    @analytic.temperature = data[:temperature],
    @analytic.entry_id = entry_id
    @analytic.save!

    data[:words].each do |pair|
      @word_freq = WordFrequency.find_or_initialize_by(analytic: @analytic, word: pair[0])
      @word_freq.frequency = pair[1]
      @word_freq.save!
    end

    data[:people].each do |word|
      @name_freq = NameFrequency.find_or_initialize_by(analytic: @analytic, name: word)
      @name_freq.save!
    end

    data[:emotion].each do |pair|
      @emotion = Emotion.find_or_initialize_by(analytic: @analytic, emotion: pair[0].downcase)
      @emotion.level = pair[1]*100
      @emotion.save!
    end
  end
end

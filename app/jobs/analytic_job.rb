class AnalyticJob < ApplicationJob
  queue_as :default

  def perform(entry_id)
    entry = Entry.find(entry_id)
    location = entry.location
    created_day = entry.created_at
    created_time = entry.created_at.hour
    time_spent = ((entry.created_at - entry.start_entry) / 60).to_s
    emoji = entry.emoji
    # data = EntryHelper::analyze(entry)
    data = {
            word_count: 100,
            words: {"hello" => 5, "Emilie" => 3, "Sebas" => 10},
            emotion: "happy",
            weather: "sunny",
            temperature: "22",
            people: ["Anna", "James", "Kevin"]
           }

    @analytic = Analytic.create(
      time_spent: time_spent,
      created_day: created_day,
      created_time: created_time,
      emoji: emoji,
      location: location,
      word_count: data[:word_count],
      emotion: data[:emotion],
      weather: data[:weather],
      people: data[:people],
      temperature: data[:temperature],
      entry_id: entry_id
    )

    data[:words].each do |word, count|
      WordFrequency.create(word: word, frequency: count, analytic: @analytic)
    end
  end
end

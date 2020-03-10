module EntryHelper

EMPTY_VALUE = "N/A"

STOPWORDS = ["i",
 "me",
 "my",
 "myself",
 "we",
 "our",
 "ours",
 "ourselves",
 "you",
 "your",
 "yours",
 "yourself",
 "yourselves",
 "he",
 "him",
 "his",
 "himself",
 "she",
 "her",
 "hers",
 "herself",
 "it",
 "its",
 "itself",
 "they",
 "them",
 "their",
 "theirs",
 "themselves",
 "what",
 "which",
 "who",
 "whom",
 "this",
 "that",
 "these",
 "those",
 "am",
 "is",
 "are",
 "was",
 "were",
 "be",
 "been",
 "being",
 "have",
 "has",
 "had",
 "having",
 "do",
 "does",
 "did",
 "doing",
 "a",
 "an",
 "the",
 "and",
 "but",
 "if",
 "or",
 "because",
 "as",
 "until",
 "while",
 "of",
 "at",
 "by",
 "for",
 "with",
 "about",
 "against",
 "between",
 "into",
 "through",
 "during",
 "before",
 "after",
 "above",
 "below",
 "to",
 "from",
 "in",
 "out",
 "on",
 "off",
 "over",
 "under",
 "again",
 "further",
 "then",
 "once",
 "here",
 "there",
 "when",
 "where",
 "why",
 "how",
 "all",
 "any",
 "both",
 "each",
 "few",
 "more",
 "most",
 "other",
 "some",
 "such",
 "no",
 "nor",
 "not",
 "only",
 "own",
 "same",
 "so",
 "than",
 "too",
 "very",
 "s",
 "t",
 "can",
 "will",
 "just",
 "don",
 "should",
 "now",
  "ll",
  "wasn",
"-",
"_",
".",
"?",
"!",
"'",
":"]

  def self.analyze(entry)
    {
      word_count: self.counter(entry.content),
      words: self.frequency(entry.content),
      emotion: self.emotion(entry.content),
      weather: self.weather(entry.created_at, entry.latitude, entry.longitude),
      people: self.names(entry.content)
    }
  end

  def self.emotion(text)
    response = RestClient.post "https://apis.paralleldots.com/v4/emotion", { api_key: "aaLdmuiYsfEz4SmRmF334ikgml52ndxUSPJR83pAxDQ", text: text }
    data = JSON.parse( response )
    return EMPTY_VALUE if data["code"] == 400
    data["emotion"]
  end

  def self.names(text)
    response = RestClient.post "https://apis.paralleldots.com/v4/ner", { api_key: "aaLdmuiYsfEz4SmRmF334ikgml52ndxUSPJR83pAxDQ", text: text }
    data = JSON.parse( response )
    return EMPTY_VALUE if data["code"] == 400
    names_array = []
    data["entities"].each do | names_hash |
      if (names_hash["category"] == "name") && (names_hash["confidence_score"] >= 0.60)
        names_array << names_hash["name"]
      end
    end
    names_array.uniq
  end

  def self.counter(text)
    counter = WordsCounted.count(text)
    counter.token_count
  end

  def self.frequency(text)
    dirty_array = text.downcase.split(/\b/)
    cleaned_array = dirty_array.reject {|term| (STOPWORDS.include? term) || (term.length < 3)}
    text = cleaned_array.join(" ")
    counter = WordsCounted.count(text)
    counter.token_frequency.first(10)
  end

  def self.weather(date, latitude, longitude)
    response = RestClient.get "https://api.darksky.net/forecast/fe0831cdbe63483548a3ed76d5c67742/#{latitude},#{longitude},#{date.to_time.to_i}?exclude=currently,flags"
    data = JSON.parse( response )
    description = data["daily"]["data"].first["icon"]
    temperature = data["daily"]["data"].first["temperatureHigh"]
    {description: description, temperature: temperature}
    rescue RestClient::BadRequest => e
      {description: EMPTY_VALUE, temperature: EMPTY_VALUE}
    rescue RestClient::Forbidden => e
      {description: EMPTY_VALUE, temperature: EMPTY_VALUE}
  end
end

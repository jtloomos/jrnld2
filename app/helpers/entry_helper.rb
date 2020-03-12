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
      weather: self.weather(entry.latitude, entry.longitude),
      people: self.names(entry.content)
    }
  end

  def self.emotion(text)
    response = RestClient.post "https://apis.paralleldots.com/v4/emotion", { api_key: "aaLdmuiYsfEz4SmRmF334ikgml52ndxUSPJR83pAxDQ", text: text }
    data = JSON.parse( response )
    return [] if [400, 403].include? data["code"]
    data["emotion"]
  end

  def self.names(text)
    response = RestClient.post "https://apis.paralleldots.com/v4/ner", { api_key: "aaLdmuiYsfEz4SmRmF334ikgml52ndxUSPJR83pAxDQ", text: text }
    data = JSON.parse( response )
    return [] if [400, 403].include? data["code"]
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
    counter.token_frequency.first(30)
  end

  def self.weather(latitude, longitude)
    response = RestClient.get "api.openweathermap.org/data/2.5/weather?lat=#{latitude}&lon=#{longitude}&units=imperial&appid=94fa99376d961a3cec23c781e7cc1fe2"
    data = JSON.parse( response )
    description = data["weather"].first["main"]
    temperature = data["main"]["temp"]
    {description: description, temperature: temperature}
    rescue RestClient::BadRequest => e
      {description: EMPTY_VALUE, temperature: EMPTY_VALUE}

    rescue RestClient::Forbidden => e
      {description: EMPTY_VALUE, temperature: EMPTY_VALUE}
  end
end

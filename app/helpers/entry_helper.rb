module EntryHelper

  def self.analyze(entry)
    {
      word_count: self.counter(entry.content),
      words: self.frequency(entry.content),
      emotion: self.emotion(entry.content),
      weather: self.weather(entry.created_at, entry.latitude, entry.longtitude),
      temperature: self.temperature(entry.created_at, entry.latitude, entry.longtitude),
      people: self.names(entry.content)
    }
  end

  def self.emotion(text)
    response = RestClient.post "https://apis.paralleldots.com/v4/emotion", { api_key: "Sn1y3EVI3MbKSYhPfkEWmmA2h9J8FCfHdABcX9hsKRo", text: text }
    data = JSON.parse( response )
  end

  def self.names(text)
    response = RestClient.post "https://apis.paralleldots.com/v4/ner", { api_key: "Sn1y3EVI3MbKSYhPfkEWmmA2h9J8FCfHdABcX9hsKRo", text: text }
    data = JSON.parse( response )
    names_array = []
    data["entities"].each do | names_hash |
      if names_hash["category"] == "name"
        names_array << names_hash["name"]
      end
    end
    names_array
  end

  def self.counter(text)
    counter = WordsCounted.count(text)
    counter.token_count
  end

  def self.frequency(text)
    counter = WordsCounted.count(text)
    counter.token_frequency.first(5)
  end

  def self.weather(date, latitude, longtitude)
    response = RestClient.get "https://api.darksky.net/forecast/f9f27a4fe0552c816b83982f83238af6/#{latitude},#{longtitude},#{date}?exclude=currently,flags"
    data = JSON.parse( response )
    weather = data["daily"]["data"].first["icon"]
  end

  def self.temperature(date, latitude, longtitude)
    response = RestClient.get "https://api.darksky.net/forecast/f9f27a4fe0552c816b83982f83238af6/#{latitude},#{longtitude},#{date}?exclude=currently,flags"
    data = JSON.parse( response )
    temperature = data["daily"]["data"].first["temperatureHigh"]
  end
end

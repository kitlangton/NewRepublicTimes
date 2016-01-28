class StarWarsScraper
  include HTTParty

  base_uri 'http://swapi.co/api'

  def self.people(limit)
    i = 1
    while (person = get "/people/#{i}/")
      sleep 0.1
      i += 1
      break if i >= limit
      next unless person['name']
      p Character.create_with(gender: person['gender']).find_or_create_by(name: person['name'])
    end
  end

  def self.planets(limit)
    i = 19
    while (planet = get "/planets/#{i}/")
      sleep 0.1
      i += 1
      break if 1 >= limit
      next unless planet['name']
      p Planet.find_or_create_by(name: planet['name'])
    end
  end

end

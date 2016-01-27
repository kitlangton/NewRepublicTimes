class StarWarsScraper
  include HTTParty

  base_uri 'http://swapi.co/api'

  def self.people
    puts "How many characters?"
    limit = gets.chomp.to_i
    i = 1
    while (person = get "/people/#{i}/") && person['name'] && i < limit + 1
      sleep 0.5
      p Character.create_with(gender: person['gender']).find_or_create_by(name: person['name'])
      i += 1
    end
  end

end

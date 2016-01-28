namespace :swapi do
  desc "Scrapes SWAPI for characters"
  task characters: :environment do
    StarWarsScraper.people(100)
  end

  desc "TODO"
  task planets: :environment do
    StarWarsScraper.planets(100)
  end
end

namespace :swapi do
  desc "Scrapes SWAPI for characters"
  task characters: :environment do
    StarWarsScraper.people(200)
  end

  desc "TODO"
  task planets: :environment do
    StarWarsScraper.planets(200)
  end
end

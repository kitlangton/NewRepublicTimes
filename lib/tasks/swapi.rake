namespace :swapi do
  desc "Scrapes SWAPI for characters"
  task characters: :environment do
    StarWarsScraper.people
  end

  desc "TODO"
  task planets: :environment do
  end

end

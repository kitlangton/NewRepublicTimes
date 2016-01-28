namespace :times do
  desc "Scrape Articles"
  task articles: :environment do
    ARTICLES = [
      "http://www.nytimes.com/2016/01/27/us/politics/trump-feud-fox-debate.html?ref=politics&_r=0",
      "http://www.nytimes.com/2016/01/27/us/politics/ted-cruz-and-allies-work-to-halt-donald-trumps-gains.html?ref=politics",
      "http://www.nytimes.com/2016/01/28/us/politics/iowa-caucus-donald-trump.html?ref=politics",
      "http://www.nytimes.com/politics/first-draft/2016/01/26/donald-trump-will-skip-next-republican-debate-his-campaign-manager-says/",
      "http://www.nytimes.com/2016/01/28/us/politics/bernie-sanders-hillary-clinton-iowa.html"
    ]

    ARTICLES.each do |url|
      TimesScraper.new.scrape(url)
    end
  end

end

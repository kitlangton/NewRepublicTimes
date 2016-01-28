require 'mechanize'

class TimesScraper
  def initialize
    @mech = Mechanize.new
  end

  def scrape(url)
    content = nil
    heading = nil
    @mech.get(url) do |page|
      content = page.css(".story-body-text")
      heading = page.css("#story-heading")
    end
    body =  content.map{ |el| el.text }.join "\n"
    heading = heading.text

    Article.create(body: body, title: heading )
  end
end

# TimesScraper.new.scrape("http://www.nytimes.com/2016/01/27/us/politics/trump-feud-fox-debate.html?ref=politics&_r=0")

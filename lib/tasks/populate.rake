require 'pry'

namespace :datapad do
  desc 'Populate Data'
  task populate: :environment do
    s = Scraper.new
    s.scrape_on!
  end
end

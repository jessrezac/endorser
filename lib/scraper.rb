require "nokogiri"
require "open-uri"
require "pry"

class Scraper
    def initialize
        puts "hello, where should i scrape?"
        input = gets.chomp
        fetch_episodes(input)
        write_books(episodes)
    end

    def fetch_episodes(path)
        html = open(path)
        doc = Nokogiri::HTML(html)
        description = doc.css(".ln-channel-episode-description-text > strong ~ a")

        books = []
        description.each do |link|
            book_path = link.attribute("href")
            
            books << book_path
            
        end

        binding.pry
    end
end

Scraper.new
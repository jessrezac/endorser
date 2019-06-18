require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        puts "hello, where should i scrape?"
        input = "https://player.fm/series/the-ezra-klein-show"
        fetch_episodes(input)
        write_books(episodes)
    end
    
    def fetch_episodes(path)
      html = open(path)
      doc = Nokogiri::HTML(html)
      
      episodes = doc.css(".info")
      
      episodes.each do |episode|
        title = 
        link = 
        
        binding.pry
        
        Episode.new
      end
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
class PodcastBookClub::CLI

    def call
        puts "Welcome to Podcast Book Club"
        Scraper.new
    end

end
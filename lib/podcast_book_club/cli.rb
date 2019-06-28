class PodcastBookClub::CLI

    def initialize
        call
    end

    def call
        puts "Welcome to Podcast Book Club!"
        puts "The Ezra Klein Show brings you far-reaching conversations about hard problems, big ideas,"
        puts "illuminating theories, and cutting-edge research."
        puts "Podcast Book Club lets you climb around the guests' bookshelves."
        puts "Let's get started!"
        puts ""
        puts "Loading episodes..."
        puts ""
        Scraper.new
        puts "To list available episodes to build a library, enter 'list episodes'."
        puts "To create a library from all episodes, enter 'create library'."
        puts ""
        puts "What would you like to do?"
        input = gets.chomp
        binding.pry 

    end

end
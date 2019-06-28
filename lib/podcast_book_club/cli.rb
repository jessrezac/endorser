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
        @scraper = Scraper.new
        puts "To list available episodes to build a library, enter 'list episodes'."
        puts "To create a library from all episodes, enter 'create library'."
        puts ""
        puts "What would you like to do?"
        input = gets.chomp.downcase

        until input == "exit"

            case input
            when "list episodes"
                Episode.all.map {|episode| "#{episode.title}"}
            when "create library"
                Episode.all.each do |episode|
                    @scraper.build_books(episode)
                end

                binding.pry
            else
                puts "Sorry, I did not understand your response."
                puts "What would you like to do?"
                input = gets.chomp.downcase
            end

        end

    end

end
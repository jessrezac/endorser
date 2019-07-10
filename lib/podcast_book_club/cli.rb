class PodcastBookClub::CLI

    def initialize
        call
    end

    def call
        puts "                          _               _     _                 _           _       _     
         _ __   ___   __| | ___ __ _ ___| |_  | |__   ___   ___ | | __   ___| |_   _| |__  
        | '_ \\ / _ \\ / _` |/ __/ _` / __| __| | '_ \\ / _ \\ / _ \\| |/ /  / __| | | | | '_ \\ 
        | |_) | (_) | (_| | (_| (_| \\__ \\ |_  | |_) | (_) | (_) |   <  | (__| | |_| | |_) |
        | .__/ \\___/ \\__,_|\\___\\__,_|___/\\__| |_.__/ \\___/ \\___/|_|\\_\\  \\___|_|\\__,_|_.__/ 
        |_|                                                                                

"
        puts "The Ezra Klein Show brings you far-reaching conversations about hard problems, big ideas,"
        puts "illuminating theories, and cutting-edge research."
        puts "Podcast Book Club lets you climb around the guests' bookshelves."
        puts "Let's get started!\n\n"

        puts "Loading episodes...\n\n"
        
        @scraper = Scraper.new
        
        puts "To list available episodes to build a library, enter 'list episodes'."
        puts "To create a library from all episodes, enter 'create library'.\n\n"
        puts "What would you like to do?"
        input = gets.chomp.downcase

        until input == "exit"

            case input
            when "list episodes"
                puts "\n\nChoose a timeframe to list episodes:"
                puts "1. 'this week'"
                puts "2. 'last week'"
                puts "3. 'this month'"
                puts "4. 'last month'"
                puts "5. 'this year'"
                puts "6. 'search' by keyword"
                timeframe = gets.chomp.downcase

                case timeframe
                when "1" || "this week" || "1. this week"
                    puts "I'm listing episodes from this week"
                    timeframe = gets.chomp.downcase

                when "2" || "last week" || "2. last week"
                    puts "I'm listing episodes from last week"
                    timeframe = gets.chomp.downcase

                when "3" || "this month" || "3. this month"
                    puts "I'm listing episodes from this month"
                    timeframe = gets.chomp.downcase

                when "4" || "last month" || "4. last month"
                    puts "I'm listing episodes from last month"
                    timeframe = gets.chomp.downcase

                when "5" || "this year" || "5. this year"
                    puts "I'm listing episodes from this year"
                    timeframe = gets.chomp.downcase

                when "6" || "search" || "6. search by keyword"
                    puts "Enter a keyword or phrase:"
                    keyword = gets.chomp
                    episodes = Episode.find_by_keyword(keyword)
                    puts "I have found #{episodes.count} episode(s).\n\n"
                    episodes.map.with_index { |episode, i| puts "#{i} - #{episode.title} - #{episode.date}" }
                    timeframe = gets.chomp.downcase

                when "exit"
                    input = "exit"
                else
                    puts "Sorry, I did not understand your response."
                    puts "What would you like to do?"
                    timeframe = gets.chomp.downcase
                end

            when "create library"
                Episode.all.each do |episode|
                    @scraper.build_books(episode) rescue binding.pry
                                        
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
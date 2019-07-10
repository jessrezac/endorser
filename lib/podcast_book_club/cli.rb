class PodcastBookClub::CLI

    def initialize
        call
    end

    def call
        puts "                         _               _     _                 _           _       _     
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
        @input = gets.chomp.downcase

        until @input == "exit"

            case @input
            when "list episodes"
                list_episodes

            when "create library"
                create_library(Episode.all)
            else
                unexpected_input
                @input = gets.chomp.downcase
            end

        end

    end

    def list_episodes
        @today = Date.today

        puts "\n\nChoose a timeframe to list episodes:"
        puts "1. 'this week'"
        puts "2. 'last week'"
        puts "3. 'this month'"
        puts "4. 'last month'"
        puts "5. 'this year'"
        puts "6. 'search' by keyword\n\n"
        puts "Enter your selection:"

        selection = gets.chomp.downcase

        case selection
        when "1", "this week", "1. this week"
            first_date = @today - @today.wday
            episodes = Episode.find_by_date(first_date, @today)

            puts_episodes(episodes)

            puts "Enter the number of the episode to see recommended books or enter 'all' to create a library from all listed episodes."
            option_3 = gets.chomp.downcase

        when "2", "last week", "2. last week"
            first_date = @today - @today.wday - 7
            last_date = @today - @today.wday
            episodes = Episode.find_by_date(first_date, last_date)

            puts_episodes(episodes)

            selection = gets.chomp.downcase

        when "3", "this month", "3. this month"
            first_date = @today - @today.mday + 1
            episodes = Episode.find_by_date(first_date, @today)

            puts_episodes(episodes)
            
            selection = gets.chomp.downcase

        when "4", "last month", "4. last month"
            last_date = @today - @today.mday
            first_date = last_date - last_date.mday + 1
            episodes = Episode.find_by_date(first_date, last_date)

            puts_episodes(episodes)

            selection = gets.chomp.downcase

        when "5", "this year", "5. this year"
            first_date = @today - @today.yday + 1
            episodes = Episode.find_by_date(first_date, @today)

            puts_episodes(episodes)

            selection = gets.chomp.downcase

        when "6", "search", "6. search by keyword"
            puts "Enter a keyword or phrase:"
            keyword = gets.chomp.downcase
            episodes = Episode.find_by_keyword(keyword)

            puts_episodes(episodes)

            selection = gets.chomp.downcase

        when "exit"
            @input = "exit"
        else
            unexpected_input
            timeframe = gets.chomp.downcase
        end
    end

    def create_library(episodes)
        episodes.each do |episode|
            @scraper.build_books(episode) rescue binding.pry                     
        end
    end

    def unexpected_input
        puts "Sorry, I did not understand your response."
        puts "What would you like to do?"
    end

    def puts_episodes(episodes)
        puts "I have found #{episodes.count} episode(s).\n\n"
        episodes.map.with_index { |episode, i| puts "#{i+1} - #{episode.title} - #{episode.date}" }
    end

end
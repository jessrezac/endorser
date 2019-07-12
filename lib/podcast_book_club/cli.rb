class PodcastBookClub::CLI

    def initialize
        welcome_message
        @scraper = Scraper.new
        call
    end

    def call

        until @input == "exit"
        
            puts "To list available episodes to build a library, enter 'list episodes'."
            puts "To create a library from all episodes, enter 'create library'.\n\n"
    
            puts "Congratulations! You have some books in your library!\n\n" if Book.count > 0
            puts "To explore your library, enter 'explore'.\n\n" if Book.count > 0
    
            puts "What would you like to do?"
            @input = gets.chomp.downcase


            case @input
            when "list episodes"
                list_episodes

            when "create library"
                create_library(Episode.all)

            when "explore"
                explore_bookshelf

            when "exit"
                break

            else
                unexpected_input
                @input = gets.chomp.downcase
            end

        end

    end

    def list_episodes
        @today = Date.today

        @sub_option = ""

        until @sub_option == "return"
            puts "\n\nChoose a timeframe to list episodes:"
            puts "1. 'this week'"
            puts "2. 'last week'"
            puts "3. 'this month'"
            puts "4. 'last month'"
            puts "5. 'this year'"
            puts "6. 'search' by keyword\n\n"
            puts "Enter your selection:"
    
            @sub_option = gets.chomp.downcase
    

            case @sub_option
            when "1", "this week", "1. this week"
                first_date = @today - @today.wday
                episodes = Episode.find_by_date(first_date, @today)

                select_episodes(episodes)

            when "2", "last week", "2. last week"
                first_date = @today - @today.wday - 7
                last_date = @today - @today.wday
                episodes = Episode.find_by_date(first_date, last_date)

                select_episodes(episodes)

            when "3", "this month", "3. this month"
                first_date = @today - @today.mday + 1
                episodes = Episode.find_by_date(first_date, @today)
                
                select_episodes(episodes)

            when "4", "last month", "4. last month"
                last_date = @today - @today.mday
                first_date = last_date - last_date.mday + 1
                episodes = Episode.find_by_date(first_date, last_date)

                select_episodes(episodes)

            when "5", "this year", "5. this year"
                first_date = @today - @today.yday + 1
                episodes = Episode.find_by_date(first_date, @today)

                select_episodes(episodes)

            when "6", "search", "6. search by keyword"
                puts "\n\nEnter a keyword or phrase:"
                keyword = gets.chomp.downcase
                episodes = Episode.find_by_keyword(keyword)

                select_episodes(episodes)

            when "return"
                break

            when "exit"
                @input = "exit"
                break
            else
                unexpected_input
                @sub_option = gets.chomp.downcase
            end
        end
    end

    def create_library(episodes)
        episodes.each do |episode|
            @scraper.build_books(episode) unless episode.books != [] rescue binding.pry

            puts "\n\nHere are the recommendations from \"#{episode.title}\":\n\n"

            episode.books.each_with_index do |book, i|
                output_book(book, i+1)
            end    
        end
    end

    def explore_bookshelf
        @shelf_option = ""

        puts "\n\nExplore by:"
        puts "'author'"
        puts "'genre'"
        puts "keyword 'search'"

        puts "\n\nWhat would you like to do?"

        until @shelf_option == "return"
            @shelf_option = gets.chomp.downcase

            case @shelf_option
            when "author"
                puts "I'm searching by author"

            when "genre"
                puts "I'm searching by genre"

            when "search"
                puts "I'm searching by keyword"

            when "return"
                break

            when "exit"
                @input = "exit"
                break
            else
                unexpected_input
            end

        end
    
    end

    def select_episodes(episodes)
        @selection = ""

        until @selection == "return"
            select_menu(episodes)
            @selection = gets.chomp.downcase
    
            case @selection
            when /\d/
                unless @selection.to_i > episodes.count
                    episodes = [episodes[@selection.to_i - 1]]
                    create_library(episodes)
                else
                    unexpected_input
                end
            when "all"
                create_library(episodes)
            when "return"
                break
            when "exit"
                @input = "exit"
                break
            else
                unexpected_input
            end

        end

    end

    private
    def welcome_message
        puts "                        _               _     _                 _           _       _     
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
    end

    def unexpected_input
        puts "\n\nSorry, I did not understand your response."
        puts "What would you like to do?"
    end

    def puts_episodes(episodes)
        puts "\n\nI have found #{episodes.count} episode(s).\n\n"
        episodes.map.with_index { |episode, i| puts "#{i+1} - #{episode.title} - #{episode.date}" }
    end

    def select_menu(episodes)
        puts_episodes(episodes)

        puts "\n\nEnter the number of the episode to see recommended books or enter 'all' to create a library from all listed episodes."
        puts "Enter 'return' to return to previous menu or 'exit' to close program."
        puts "\n\nWhat would you like to do?"
    end

    def output_book(book, i)

        authors = []
        genres = []
        book.author.each {|a| authors << a.name} unless book.author == []
        book.genre.each {|g| genres << g.name} unless book.genre == []

        puts "#{i + 1} - #{book.title}"
        puts "Author(s): #{authors.join(", ")}" unless authors == []
        puts "Genre: #{genres.join(", ")}" unless genres == []
        puts "Synopsis: #{book.synopsis}\n\n"
        puts "URL: #{book.url}\n\n"

    end

end
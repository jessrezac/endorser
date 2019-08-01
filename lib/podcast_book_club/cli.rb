class PodcastBookClub::CLI

    def initialize
        welcome_message
        @today = Date.today
        
        Whirly.start(spinner: "pencil", color: false, remove_after_stop: true, status: "Loading Episodes") do
            @scraper = Scraper.new
        end

        call
    end

    def call

        until @input == "exit"

            menu_options

            puts "\n\nEnter your selection:"
            @input = gets.chomp.downcase

            case @input
            when "1", "this week"
                first_date = @today - @today.wday
                episodes = Episode.find_by_date(first_date, @today)

                select_episodes(episodes)

            when "2", "last week"
                first_date = @today - @today.wday - 7
                last_date = @today - @today.wday
                episodes = Episode.find_by_date(first_date, last_date)

                select_episodes(episodes)

            when "3", "this month"
                first_date = @today - @today.mday + 1
                episodes = Episode.find_by_date(first_date, @today)

                select_episodes(episodes)

            when "4", "last month"
                last_date = @today - @today.mday
                first_date = last_date - last_date.mday + 1
                episodes = Episode.find_by_date(first_date, last_date)

                select_episodes(episodes)

            when "5", "this year"
                first_date = @today - @today.yday + 1
                episodes = Episode.find_by_date(first_date, @today)

                select_episodes(episodes)

            when "6", "keyword"
                puts "\n\nEnter a keyword or phrase:"
                keyword = gets.chomp.downcase
                episodes = Episode.find_by_keyword(keyword)

                select_episodes(episodes)

            when "7", "author"

                if Book.count > 0
                    Author.sort_by_name.each { |author| output_author(author) }
                else
                    no_books
                end

            when "8", "genre"

                if Book.count > 0
                    Genre.sort_by_name.each { |genre| output_genre(genre) }
                else
                    no_books
                end

            when "9", "search"

                if Book.count > 0
                    puts "\n\nEnter a keyword or phrase:"
                    keyword = gets.chomp.downcase
                    books = Book.find_by_keyword(keyword)

                    books.each_with_index do |book, i|
                        episodes = book.episode.map { |ep| ep.title}

                        output_book(book, i+1)
                        puts "From the episode(s): #{episodes.join(", ")}\n\n"
                    end

                else
                    no_books
                end

            when "animal style"
                create_library(Episode.all)

            when "help"
                menu_options

            when "exit"
                break

            else
                unexpected_input

            end

        end

    end


    def create_library(episodes)
        episodes.each do |episode|

            @scraper.build_books(episode) unless episode.books != []

            puts "\n\nHere are the recommendations from \"#{episode.title}\":\n\n"

            episode.books.each_with_index do |book, i|
                output_book(book, i+1)
            end
        end
    end

    def select_episodes(episodes)

        select_menu(episodes)
        @selection = gets.chomp.downcase

        case @selection
        when /\d/
            unless @selection.to_i > episodes.count
                selected_episodes = [episodes[@selection.to_i - 1]]
                create_library(selected_episodes)

            else
                unexpected_input
                select_menu(episodes)
                @selection = gets.chomp.downcase

            end

        when "all"
            create_library(episodes)
        when "back"
            call
        when "exit"
            @input = "exit"
        else
            unexpected_input
        end

    end

    private
    def welcome_message
        puts Rainbow("                        _               _     _                 _           _       _
        _ __   ___   __| | ___ __ _ ___| |_  | |__   ___   ___ | | __   ___| |_   _| |__
       | '_ \\ / _ \\ / _` |/ __/ _` / __| __| | '_ \\ / _ \\ / _ \\| |/ /  / __| | | | | '_ \\
       | |_) | (_) | (_| | (_| (_| \\__ \\ |_  | |_) | (_) | (_) |   <  | (__| | |_| | |_) |
       | .__/ \\___/ \\__,_|\\___\\__,_|___/\\__| |_.__/ \\___/ \\___/|_|\\_\\  \\___|_|\\__,_|_.__/
       |_|

").yellow.bright

       puts Rainbow(" The Ezra Klein Show ").black.bg(:yellow).bright + " brings you far-reaching conversations about hard problems, big ideas,"
       puts "illuminating theories, and cutting-edge research.\n\n"
       puts Rainbow(" Podcast Book Club ").black.bg(:yellow).bright + " lets you climb around the guests' bookshelves."
       puts "Let's get started!\n\n"
    end

    def menu_options

        puts "\n\nList episodes:"
        puts "1. from 'this week'"
        puts "2. from 'last week'"
        puts "3. from 'this month'"
        puts "4. from 'last month'"
        puts "5. from 'this year'"
        puts "6. by 'keyword'"

        if Book.count > 0
            puts "\n\n" + Rainbow("It looks like you've found some books!").black.bg(:yellow).bright
            puts "Explore bookshelf:"
            puts "7. by 'author'"
            puts "8. by 'genre'"
            puts "9. 'search'"
        end

        puts "\n\n'help' for options or 'exit'"

    end

    def unexpected_input
        puts "\n\nSorry, I did not understand your response."
        puts "What would you like to do?"
    end

    def puts_episodes(episodes)
        puts "\n\nI have found " + Rainbow(episodes.count).bg(:black).yellow.bright + " episode(s).\n\n"
        episodes.each.with_index { |episode, i| output_episode(episode, i+1) }
    end

    def select_menu(episodes)
        puts_episodes(episodes)

        puts "\n\nEnter the number of the episode to see recommended books or enter 'all' to create a library from all listed episodes."
        puts "Use 'back' for previous menu or 'exit' to close program."
        puts "\n\nWhat would you like to do?"
    end

    def output_book(book, number)

        authors = book.author.map {|a| a.name} unless book.author == [] || book.author == nil
        genres = book.genre.map {|g| g.name} unless book.genre == [] || book.genre == nil
        puts Rainbow("#{number} - #{book.title}").bg(:black).yellow.bright
        puts Rainbow("Author(s): ").bg(:black).yellow.bright + authors.join(", ") unless authors == [] || authors == nil
        puts Rainbow("Genre: ").bg(:black).yellow.bright + genres.join(", ") unless genres == [] || genres == nil
        puts Rainbow("Synopsis: ").bg(:black).yellow.bright + "#{book.synopsis}" unless book.synopsis == ""
        puts Rainbow("URL: ").bg(:black).yellow.bright + "#{book.url}\n\n"

    end

    def output_episode(episode, number, display_description = false)
        puts "#{number} - " + Rainbow("#{episode.title}").bg(:black).yellow.bright + " - #{episode.date}"
        puts "#{episode.description}" if display_description == true
    end

    def output_author(author)
        puts "\n\n" + Rainbow("#{author.name}").bg(:black).yellow.bright + Rainbow(" (#{author.books.count})").silver

        sorted_books = author.books.sort_by { |book| book.title}
        sorted_books.each do |book|
            puts "  #{book.title}"
        end

    end

    def output_genre(genre)
        puts "\n\n" + Rainbow("#{genre.name}").bg(:black).yellow.bright + " (#{genre.books.count})"

        sorted_books = genre.books.sort_by { |book| book.title}
        sorted_books.each do |book|
            authors = []
            book.author.each { |author| authors << author.name}

            puts "  #{book.title} by #{authors.join(", ")}"
        end
    end

    def no_books
        puts "Your library has no books! Find an episode to begin building your library."
        menu_options
    end

end
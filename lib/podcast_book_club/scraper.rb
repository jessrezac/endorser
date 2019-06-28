require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        path = build_path
        fetch_episodes(path)
        build_books(Episode.all[7])
    end

    def fetch_episodes(path)
      html = open(path)
      doc = Nokogiri::HTML(html)

      episodes = doc.css(".info")

      episodes.each do |episode|
        title = episode.css(".info-top a").text.strip
        link = "https://player.fm#{episode.css(".info-top a").attribute("href").value}"
        date = episode.css(".timeago").attribute("datetime").value
        date.slice!(/T.+/)

        attributes = {
            title: title,
            link: link,
            date: date}

        Episode.new(attributes)
      end
    end

    def build_books(episode)
      describe_episode(episode)
      queries = send_to_parser(episode)

      queries.each do |query|
        google_book_search = GoogleBooks.search(query)
        result = google_book_search.first

        url = result.info_link
        title = result.title
        author = result.authors_array
        genre = result.categories
        synopsis = result.description
        book_episode = episode
        
        Book.new({
          url: url,
          title: title,
          author: author,
          genre: genre,
          synopsis: synopsis,
          episode: episode
        })
  
      end

    end

    def build_path
        snapshot_date = Date.new(2019,6,25)
        today = Date.today
        episodes_since_snapshot = snapshot_date.step(today).select{|d| d.monday? || d.wednesday?}.size
        url = "https://player.fm/series/the-ezra-klein-show/episodes?active=true&limit=#{episodes_since_snapshot + 225}&order=newest&query=&style=list&container=false&offset=0"
    end

    def describe_episode(episode)
      path = episode.link

      html = open(path)
      @episode_doc = Nokogiri::HTML(html)
      @description = @episode_doc.css(".story .description").text
    end

    def send_to_parser(episode)
      today = Date.today
      with_links = Date.new(2019, 1, 14)
      without_links = Date.new(2017, 3, 28)

      case episode.date
      when (with_links..today)
        parse_with_links(episode)
      when (without_links...with_links)
        parse_without_links(episode)
      else 
        puts "This episode has no recommendations."
      end

    end

    def parse_with_links(episode)
        book_titles = []

        book_links = @episode_doc.css(".description.prose>strong~a")

        book_links.map do |link|
            book_titles << link.text
        end

        description = @description.split(book_titles[0]).pop.to_s

        books = []

        book_titles.map.with_index do |title, i|
          unless i + 1 == book_titles.length
            description = description.split(book_titles[i+1 || i])
            author = description[0]

            books << "#{title}#{author}"

            description = description.pop

          else

            books << "#{title}#{description}"

          end

        end

        books 

    end

    def parse_without_links(episode)
        after_books = @description.split(/(B|b)ooks:\s/)[-1]
        books = after_books.split("Notes from our sponsors")[0]
        book_array = books.strip.split(/by(\s[A-Z][a-zA-Z]*\s?a?n?d?\s?[A-Z]?[a-zA-Z]*)/)

        book_queries = []

        book_array.map.with_index do |item, i|
            if i.even?
                book_queries << "#{item.strip} #{book_array[i+1]}"
            end
        end

        book_queries

      end

  end

Scraper.new
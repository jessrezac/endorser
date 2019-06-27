require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        path = build_path
        fetch_episodes(path)
        build_books(Episode.all[19])
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
      choose_parser(episode)
      book_queries = parse_descriptions(episode, @episode_doc)

    end


    def parse_descriptions(episode, doc)
        book_titles = []

        book_links = doc.css(".description.prose>strong~a")

        book_links.map do |link|
            book_titles << link.text
        end

        description = episode.description.split(book_titles[0]).pop.to_s

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

        binding.pry

    end

    private

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

      episode.description = @episode_doc.css(".story .description").text
    end

    def choose_parser(episode)
      books_method = Date.new(2008, 12, 22)
      recommended_method = Date.new()
      recommendations_method = Date.new(2019, 1, 14)
      

      case episode.date
      when 


        
    end

  end

Scraper.new
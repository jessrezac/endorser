require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        path = build_path
        fetch_episodes(path)
        find_books(Episode.all[225])
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

    def find_books(episode)
        path = episode.link

        html = open(path)
        doc = Nokogiri::HTML(html)

        episode.description = doc.css(".story .description").text
        book_links = doc.css(".description.prose>strong~a")
        book_titles = []
        description_text = episode.description

        book_links.map do |link|
            book_titles << link.text
        end

        description = description_text.split(book_titles[0]).pop.to_s

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

    def episode_format_predicter
      
    end

  end

Scraper.new
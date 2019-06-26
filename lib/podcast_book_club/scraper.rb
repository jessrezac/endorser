require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        puts "hello, where should i scrape?"
        path = build_path
        fetch_episodes(path)
        write_books(Episode.all)
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

    def write_books(episodes)
        episodes.each do |episode|
          path = episode.link

          html = open(path)
          doc = Nokogiri::HTML(html)

          description_links = doc.css(".description.prose>strong~a")

          description_links.each do |link|
            book_path = link.attribute("href")

            Book.new_from_url(book_path)

          end

        end

    end

    private

    def build_path
        snapshot_date = Date.new(2019,6,25)
        today = Date.today
        episodes_since_snapshot = snapshot_date.step(today).select{|d| d.monday? || d.wednesday?}.size
        url = "https://player.fm/series/the-ezra-klein-show/episodes?active=true&limit=#{episodes_since_snapshot + 225}&order=newest&query=&style=list&container=false&offset=0"
    end

  end

Scraper.new
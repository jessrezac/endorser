require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        puts "hello, where should i scrape?"
        path = build_path
        fetch_episodes(path)
        find_books(Episode.all[5])
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
            author = description.split(book_titles[ i + 1 ])[0]
            books << "#{title}#{author}"
         end

         binding.pry

#   books => "Capital in the Twenty-First Century by Thomas Piketty",
#  "Evicted: Poverty and Profit in the American City by Thomas PikettyEvicted: Poverty and Profit in the American City by Matthew Desmond",
#  "$2.00 a Day: Living on Almost Nothing in Americaby"]


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
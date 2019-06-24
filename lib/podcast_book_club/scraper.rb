require_relative "../podcast_book_club.rb"

class Scraper
    def initialize
        puts "hello, where should i scrape?"
        input = "https://player.fm/series/the-ezra-klein-show"
        fetch_episodes(input)
        write_books(Episode.all)
    end

    def build_path
        url = "https://player.fm/series/the-ezra-klein-show/episodes?active=true&limit=1000&order=newest&query=&style=list&container=false&offset=0"
    end

    def fetch_episodes(path)
      html = open(path)
      doc = Nokogiri::HTML(html)

      episodes = doc.css(".info-top")

      episodes.each do |episode|
        title = episode.css("a").text.strip
        link = "https://player.fm#{episode.css("a").attribute("href").value}"

        attributes = {title: title, link: link}

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

  end

Scraper.new
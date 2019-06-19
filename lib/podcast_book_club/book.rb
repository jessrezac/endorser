class Book
    attr_accessor :url, :title, :author, :genre, :episode

    @@all = []

    def initialize(attributes)
        attributes.each {|k,v| self.send("#{k}=", v)}
        @@all << self

        binding.pry  

    end

    def self.all
        @@all
    end

    def self.new_from_url(book_path)
        html = open(book_path)
        doc = Nokogiri::HTML(html)

        genre = doc.css("#wayfinding-breadcrumbs_feature_div li:last-child .a-link-normal").text.strip
        title = doc.css("h1#title span#productTitle").text.strip
        author = doc.css("a.contributorNameID").text.strip

        attributes = {genre: genre, title: title, author: author}
        
        Book.new(attributes)

    end

end
class Book
    attr_accessor :url, :title, :author, :genre, :episode, :synopsis

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    extend Sortable::ClassMethods
    include Memorable::InstanceMethods


    @@all = []

    def initialize(attributes)
        @episode = []

        attributes.each do |k,v|
            self.send("#{k}=", v) unless v == nil
        end

    end

    def self.all
        @@all
    end

    def episode=(episode)
        episode.add_book(self)
    end

    def author=(authors)
        @author ||= []

        if authors.kind_of?(Array)
            authors.each do |a|
                author = Author.find_or_create_by_name(a)
                @author << author
                author.books << self
            end
        else
            author = Author.find_or_create_by_name(authors)
            @author << author
            author.books = self
        end

    end

    def genre=(genre)
        @genre ||= []

        new_genre = Genre.find_or_create_by_name(genre)
        new_genre.add_book(self)
    end

    def self.find_by_keyword(keyword)
        self.all.select { |book| book.title.downcase.include?(keyword) || book.synopsis.downcase.include?(keyword) unless book.synopsis == nil }
    end

    def output(number)
        authors = []
        genres = []

        self.author.each {|a| authors << a.name} unless self.author == [] || self.author == nil
        self.genre.each {|g| genres << g.name} unless self.genre == [] || self.genre == nil

        puts Rainbow("#{number} - #{self.title}").bg(:black).yellow.bright
        puts Rainbow("Author(s): ").bg(:black).yellow.bright + authors.join(", ") unless authors == []
        puts Rainbow("Genre: ").bg(:black).yellow.bright + genres.join(", ") unless genres == []
        puts Rainbow("Synopsis: ").bg(:black).yellow.bright + "#{self.synopsis}" unless self.synopsis == ""
        puts Rainbow("URL: ").bg(:black).yellow.bright + "#{self.url}\n\n"
    end
    

end
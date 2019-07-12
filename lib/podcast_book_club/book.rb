class Book
    attr_accessor :url, :title, :author, :genre, :episode, :synopsis

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        @episode = []

        attributes.each do |k,v|
            self.send("#{k}=", v)
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
        self.all.select { |book| book.title.downcase.include?(keyword) || book.synopsis.downcase.include?(keyword) }
    end
    

end
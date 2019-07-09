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

    def author=(author)
        @author ||= []

        if author.kind_of?(Array)
            author.each do |a|
                @author << a
                a.books = self
            end
        else
            @author << author
            author.books = self
        end

    end

    def genre=(genre)
        @genre ||= []
        genre.add_book(self)
    end

end
class Author
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        @books = []

        attributes.each do |k,v|
            self.send("#{k}=", v)
        end

    end

    def self.all
      @@all
    end

    def books=(book)
        @books << book unless @books.include?(book)
    end

    def genres
        @books.map { |book| book.genre }.flatten.uniq
    end

    def output

        puts "\n\n" + Rainbow("#{self.name}").yellow.bright + Rainbow(" (#{self.books.count})").silver

        sorted_books = self.books.sort {|left, right| left.title <=> right.title}

        sorted_books.each do |book|
            puts "  #{book.title}"
        end

    end

  end
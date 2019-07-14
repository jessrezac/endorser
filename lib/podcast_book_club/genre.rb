class Genre
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    extend Sortable::ClassMethods
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

    def add_book(book)
        self.books << book unless self.books.include?(book)
        book.genre << self unless book.genre.include?(self)
        books
    end

    def authors
      @books.map { |book| book.author }.flatten.uniq
    end

    def output
      puts "\n\n" + Rainbow("#{self.name}").bg(:black).yellow.bright + " (#{self.books.count})"

      sorted_books = self.books.sort_by { |book| book.title}
      sorted_books.each do |book|
        authors = []
        book.author.each { |author| authors << author.name}

        puts "  #{book.title} by #{authors.join(", ")}"
      end
    end

  end
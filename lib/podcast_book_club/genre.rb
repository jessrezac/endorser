class Genre
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(name)

      @name = name
      @books = []

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

  end
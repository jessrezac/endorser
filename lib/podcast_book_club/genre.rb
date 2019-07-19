class Genre
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    extend Sortable::ClassMethods
    include Memorable::InstanceMethods


    @@all = []

    def initialize(attributes)
      @books = []
      @name = attributes[:name]
      @books << attributes[:book] if attributes[:book]
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
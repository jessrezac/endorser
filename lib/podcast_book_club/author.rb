class Author
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    extend Sortable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        @books = []

        @name = attributes[:name]
        self.add_book(attributes[:book])

    end

    def self.all
      @@all
    end

    def add_book(book)
        @books << book unless @books.include?(book)
    end

    def genres
        @books.map { |book| book.genre }.flatten.uniq
    end

  end
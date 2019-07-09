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
            binding.pry
        self.books.map { |book| book.genre }.uniq
    end

  end
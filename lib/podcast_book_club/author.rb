class Author
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        binding.pry
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

  end
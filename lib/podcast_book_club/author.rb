class Author
    attr_accessor :name, :books

    extend Memorable::ClassMethods
    extend Findable::ClassMethods
    include Memorable::InstanceMethods

    @@all = []

    def initialize(attributes)
        attributes.each do |k,v|
            self.send("#{k}=", v)
        end
    end

    def self.all
      @@all
    end

    def book=(book)
        @books ||= []
        @books << book
    end

    def genres
            binding.pry
        self.books.map { |book| book.genre }.uniq
    end

  end
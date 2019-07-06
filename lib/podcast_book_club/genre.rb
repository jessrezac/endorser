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
  
  end
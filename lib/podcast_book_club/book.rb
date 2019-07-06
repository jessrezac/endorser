class Book
    attr_accessor :url, :title, :author, :genre, :episode, :synopsis

    extend Memorable::ClassMethods
    include Memorable::InstanceMethods  

    @@all = []

    def initialize(attributes)
        attributes.each {|k,v| self.send("#{k}=", v)}
    end

    def self.all
        @@all
    end

end
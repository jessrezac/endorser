class Episode
  attr_accessor :title, :link, :description, :date, :books

  extend Memorable::ClassMethods
  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  @@all = []

  def initialize(attributes)

    attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    @books = []

  end

  def self.all
    @@all
  end

  def add_book(book)
    self.books << book
    books
  end


end
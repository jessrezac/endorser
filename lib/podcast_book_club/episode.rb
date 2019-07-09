class Episode
  attr_accessor :title, :link, :description, :date, :books

  extend Memorable::ClassMethods
  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  @@all = []

  def initialize(attributes)
    @books = []

    attributes.each do |k, v|
      self.send("#{k}=", v)
    end

  end

  def self.all
    @@all
  end

  def add_book(book)
    self.books << book unless self.books.include?(book)
    book.episode << self unless book.episode.include?(self)
    books
  end


end
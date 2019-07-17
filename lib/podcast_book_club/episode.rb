class Episode
  attr_accessor :title, :link, :description, :date, :books

  extend Memorable::ClassMethods
  extend Findable::ClassMethods
  extend Sortable::ClassMethods
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

  def self.find_by_keyword(keyword)
    self.all.select { |ep| ep.title.downcase.include?(keyword) }
  end


  def self.find_by_date(first_date, last_date)
    self.all.select { |ep| ep.date >= first_date && ep.date <= last_date }
  end

end
class Episode
  attr_accessor :title, :link, :description, :date

  @@all = []

  def initialize(attributes)

    attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    @@all << self

  end

  def self.all
    @@all
  end

end
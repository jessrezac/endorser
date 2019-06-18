class Episode
  attr_accessor :title, :link
  
  @@all = []
  
  def initialize(attributes)
    attributes.each { |k, v| self.send("#{k}=", v) }
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end
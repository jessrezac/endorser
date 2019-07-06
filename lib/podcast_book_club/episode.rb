class Episode
  attr_accessor :title, :link, :description, :date

  extend Memorable::ClassMethods
  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  @@all = []

  def initialize(attributes)

    attributes.each do |k, v|
      self.send("#{k}=", v)
    end

  end

  def self.all
    @@all
  end

end
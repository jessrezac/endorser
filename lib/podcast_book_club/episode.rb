class Episode
  attr_accessor :title, :link, :description, :date

  @@all = []

  def initialize(attributes)

    attributes.each do |k, v|
        if "#{k}" == "date"
            self.date = Date.strptime(v)
        else
            self.send("#{k}=", v)
        end
    end

    @@all << self

  end

  def self.all
    @@all
  end

end
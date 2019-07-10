module Findable
    module ClassMethods
        def find_by_name(name)
            self.all.detect {|i| i.name == name}
        end

        def find_by_title(title)
            self.all.detect {|i| i.title.downcase.include?(title.downcase)}
        end

        def find_or_create_by_name(attributes)
            name = attributes[name]
            instance = self.find_by_name(name) || self.create(attributes)
            instance
        end

        def find_or_create_by_title(attributes)
            title = attributes[title]
            instance = self.find_by_title(title) || self.create(attributes)
            instance
        end

        def find_by_keyword(keyword)
            self.all.select { |instance| instance.title.include?(keyword) }
        end
    end
end
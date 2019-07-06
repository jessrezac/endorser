module Findable
    module ClassMethods
        def find_by_name(name)
            self.all.detect {|i| i.name == name}
        end

        def find_by_title(title)
            self.all.detect {|i| i.title.include?(title)}
        end

        def find_or_create_by_name(attributes)
            name = attributes[name]
            instance = self.find_by_name(name) || self.create(attributes)
            intance.save
            instance
        end

        def find_or_create_by_title(attributes)
            title = attributes[title]
            instance = self.find_by_title(title) || self.create(attributes)
            instance.save
            instance
        end
    end
end
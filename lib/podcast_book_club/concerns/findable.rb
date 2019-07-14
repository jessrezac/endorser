module Findable
    module ClassMethods
        def find_by_name(name)
            self.all.detect {|i| i.name == name}
        end

        def find_by_title(title)
            self.all.detect {|i| i.title.downcase.include?(title.downcase)}
        end

        def find_or_create_by_name(name)
            instance = self.find_by_name(name) || self.create({name: name})
            instance
        end

        def find_or_create_by_title(attributes)
            title = attributes[:title]

            if self.find_by_title(title)
                instance = self.find_by_title
                instance.episode = attributes[:episode]
            else
                self.create(attributes)
            end
            
            instance
        end

    end
end
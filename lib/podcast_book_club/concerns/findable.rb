module Findable
    module ClassMethods
        def find_by_name(name)
            self.all.detect {|i| i.name == name}
        end

        def find_by_title(title)
            self.all.detect {|i| i.title.include?(title)}
        end

        def find_or_create_by_name(attributes)

        end

        def find_or_create_by_title(attributes)

        end
    end
end
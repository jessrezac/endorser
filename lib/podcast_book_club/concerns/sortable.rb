module Sortable

    module ClassMethods
        def sort_by_title
            self.all.sort {|left, right| left.title <=> right.title}
        end

        def sort_by_name
            self.all.sort {|left, right| left.name <=> right.name}
        end
    end

end

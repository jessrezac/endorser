module Memorable

    module InstanceMethods
    
        def save
            self.class.all << self
        end

    end

    module ClassMethods

        def destroy_all
            self.all = []
        end

        def count
            self.all.count 
        end

    end
end
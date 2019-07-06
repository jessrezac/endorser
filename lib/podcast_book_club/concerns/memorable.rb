module Memorable

    module InstanceMethods
    
        def save
            self.class.all << self
        end

    end

    module ClassMethods

        def destroy_all
            self.all.clear
        end

        def count
            self.all.count 
        end

        def create(attributes)
            instance = self.new(attributes)
            instance.save
            instance
        end

    end
end
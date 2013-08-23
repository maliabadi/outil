module Outil
    module Decorators
        class Sync

          def initialize(klass, method)
            @method = method
          end
         
          def call(this, *args)
            @method.bind(this).call(*args)
          end
        end
    end
end
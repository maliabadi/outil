require 'ruby_decorators'

module Outil

    module Decorators

        class Registry < RubyDecorator

          def call(this, *args, &blk)
            Outil::Workspace.scan(this.source_location)
            this.call(*args, &blk)
          end

        end

    end

end
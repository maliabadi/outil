module Outil

  module Decorators

    class Register < RubyDecorators::Decorator

      def call(this, *args, &blk)
        Outil::Workspace.scan *this.source_location << this.name
        this.call(*args, &blk)
      end

    end

    class NameSpace

        def initialize(namespace)
            @namespace = namespace
        end

        def call(this, *args, &blk)
            # TODO
            # Intended behavior is to register the decorated
            # method under a given namespace, so you can
            # have two methods named the same thing, etc.
            this.call(*args, &blk)
        end

    end

  end

end
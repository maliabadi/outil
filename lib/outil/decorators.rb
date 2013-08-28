module Outil

  module Decorators

    class Register < RubyDecorators::Decorator

      def call(this, *args, &blk)
        Outil::Workspace.scan *this.source_location << this.name
        this.call(*args, &blk)
      end

    end

  end

end
module Outil
  
  module Decorators

    class Decorator
      
      class << self
      
        attr_accessor :decorators
        def decorator_name(name)
          Decorator.decorators ||= {}
          Decorator.decorators[name] = self
        end

      end # end Decorator.self

      def self.inherited(klass)
        name = klass.name.gsub(/^./) {|m| m.downcase}

        return if name =~ /^[^A-Za-z_]/ || name =~ /[^0-9A-Za-z_]/

        MethodDecorators.module_eval <<-ruby_eval, __FILE__, __LINE__ + 1
          def #{klass}(*args, &blk)
            decorate(#{klass}, *args, &blk)
          end
        ruby_eval
      end

      def initialize(klass, method)
        @method = method
      end

    end

  end

end

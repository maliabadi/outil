require 'bundler/setup'
require 'ruby_decorators'
require 'parser/current'
require 'unparser'
require 'yaml'

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'outil/version'
require 'outil/decorators'
require 'outil/workspace'
require 'outil/ocs'
require 'outil/ocs/index'
require 'outil/ocs/config'
require 'outil/ocs/parser'

module Outil

    def self.index
        Workspace.ocs.index
    end

    def self.reset!
       Workspace.reset! 
    end

    def self.included(base)
        # Add the decorator class-method logic to the includer
        # E.G. The client has control over the "use" and "named"
        # class-level directives.
        
        base.extend(Inferace)

        # By default, only the Registration decorator
        # is added, and it's added under the generic :outil namespace

        base.class_eval do
            use Decorators::Register
            named :outil
        end

        # Pull all the AST's in the user index
        # and define them as methods of the Bucket
        # module just before the inclusion is done.
        
        Workspace.ocs.index.all.each do |ast|
            Outil.module_eval <<-RUBY_EVAL
                #{Unparser.unparse(ast)}
            RUBY_EVAL
        end
    end

    module Inferace
        # BucketInterface is a basically
        # a module mirror of the RubyDecorators::Interface
        # class. To avoid adding dependencies, and increasing
        # the sheer volume of hacks at work here, the Interface
        # code is essentially copied and pasted here as module
        # instance variables

        include RubyDecorators
        
        def self.decorate
            RubyDecorators::Stack.all << self
            Workspace.sync
        end

        def named(name)
            @name = name.to_s
            class_eval <<-RUBY_EVAL
            def self.#{@name}(dcr)
                if decorators[dcr]
                    self.decorate(decorators[dcr])
                end
            end
            RUBY_EVAL
        end

        def name
            @name ||= self.class.name.to_s
        end

        def decorators
            @decorators ||= {}
        end

        def use *decs
            append = Proc.new do |dec|
                fmt = dec.name.split('::').last.
                gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
                gsub(/([a-z\d])([A-Z])/,'\1_\2').
                tr("-", "_").
                downcase.
                to_sym
                self.decorators[fmt] = dec
            end
            decs.each &append
        end

        def registered_methods
            @registered_methods ||= {}
        end

        def self.registered_decorators
            @registered_decorators ||= {}
        end
    end
end

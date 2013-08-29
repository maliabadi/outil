require File.expand_path('../../lib/outil', __FILE__)
require 'rspec'
require 'rspec/expectations'

def build_target_ast(name=false)
    name = name ? name : :hello
    Parser::AST::Node.new(:def,
                          children=[name,
                                    Parser::AST::Node.new(:args),
                                    Parser::AST::Node.new(:str,
                                                          children=["hello"])])
end

def build_generic_parser
    Outil::OCS::ObjectParser
                .new("#{File.dirname(__FILE__)}/spec_helper.rb", 
                     :hello)
end


class DummyInterface < RubyDecorators::Interface
    use Outil::Decorators::Register
    named :outil

    outil :register
    def hello
        'hello'
    end

    outil :register
    def goodbye
        'goodbye'
    end

end

DummyInterface.new.hello

Outil::Workspace.sync
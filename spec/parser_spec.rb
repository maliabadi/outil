require 'rubygems'
require 'awesome_print'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Outil::OCS::ObjectParser do

    before do
        DummyInterface.new.hello
    end

    describe "method registration" do
        it "should parse the correctly named method" do
            my_ast = Parser::AST::Node.new(:def,
                                            children=[:hello,
                                                      Parser::AST::Node.new(:args),
                                                      Parser::AST::Node.new(:str,
                                                                            children=["hello"])])
            Outil::Workspace.asts[:hello].should eq(my_ast)
            Outil::Workspace.reset!
        end
    end

end
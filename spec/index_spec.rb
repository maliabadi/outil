require 'rubygems'
require 'awesome_print'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Outil::OCS::Index do

    before do
        DummyInterface.new.hello
    end

    describe "append" do
        it "append the ast to the designated index file" do
            my_ast = Parser::AST::Node.new(:def,
                                            children=[:hello,
                                                      Parser::AST::Node.new(:args),
                                                      Parser::AST::Node.new(:str,
                                                                            children=["hello"])])
            Outil::Workspace.sync
            Outil::Workspace.ocs.index.read(:hello).should eq(my_ast)
        end
    end

    describe "read_exec" do
        it "should produce a method" do
            Outil::Workspace.ocs.index.read_exec(:hello)
            Outil::Workspace.ocs.index.send(:hello).should eq('hello')
        end
    end



end
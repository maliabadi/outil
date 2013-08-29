require 'rubygems'
require 'awesome_print'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Outil::OCS::ObjectParser do

    before do
        Outil.reset!
        DummyInterface.new.hello
        @target = build_target_ast
    end

    after do
        Outil.reset!
    end

    describe "append" do
        it "append ast to workspace" do
            Outil::Workspace.asts[:hello].should eq(@target)
        end
    end

    describe "initialize" do
        before do
            @parser = Outil::OCS::ObjectParser.new(__FILE__, :hello)
        end
        
        it "should set path" do
            @parser.path.should eq(__FILE__)
        end

        it "should set name" do
             @parser.name.should eq(:hello)
        end
    end

    describe "node" do
        before do
            @parser = build_generic_parser
        end

        it "should return an ast" do
            @parser.node.is_a?(Parser::AST::Node).should eq(true)
        end
    end

    describe "find" do
        before do
            @parser = build_generic_parser
        end

        it "should locate the named method in the parse tree" do
            @parser.find.should eq(build_target_ast)
        end

        it "should set the found instance variable" do
            @parser.find
            @parser.found.should eq(build_target_ast)
        end

    end

end
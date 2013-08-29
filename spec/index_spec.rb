require 'rubygems'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Outil::OCS::Index do

    before do
        @config = Outil::OCS::Config.new
        @index = @config.index
    end

    describe "initialize" do
        it "should set path instance variable" do
            @index.path.should eq(@config.params[:index])
        end
    end

    describe "index_path" do
        it "should return the path with index at the end" do
            @index.index_path.should eq(@config.params[:index] + "/index")
        end
    end

    describe "write_serialize" do
        it "should write a file named for the method to the index" do
            @index.write_serialize(:hello, build_target_ast)
            Dir["#{@index.path}/*.ast"].map do |path|
                File.basename path
            end.include?("hello.ast")
                .should eq(true)
        end
    end

    describe "indexed_names" do
        it "return a list of registered methods names" do
            @index.write_serialize(:hello, build_target_ast)
            @index.indexed_names.include?("hello").should eq(true)
        end
    end

    describe "update_index" do
        it "adds a method name to the end of the index file" do
            @index.write_serialize(:dummy, build_target_ast(:dummy))
            @index.update_index :dummy
            @index.indexed_names.include?('dummy').should eq(true)
        end
    end

    describe "read" do
        it "return an ast for the specified method" do
            @index.write_serialize(:dummy, build_target_ast(:dummy))
            @index.update_index :dummy
            @index.read(:dummy).is_a?(Parser::AST::Node).should eq(true)
        end
    end

    describe "append" do

        before do
            @index.append :baz, build_target_ast(:baz)
        end

        it "should write a file named for the method to the index" do
            @index.indexed_names.include?('baz').should eq(true)
        end

        it "adds a method name to the end of the index file" do
            Dir["#{@index.path}/*.ast"].map do |path|
                File.basename path
            end.include?("baz.ast")
                .should eq(true)
        end
    end

    describe "all" do
        it "should return an array of asts" do
            all_ast = Proc.new do |response|
                response.map {|x| x.is_a?(Parser::AST::Node)}
                    .uniq == [true]
            end
            all_ast.call(@index.all)
        end
    end

    describe "read_exec" do
        it "should produce a method" do
            @index.read_exec(:hello)
            @index.send(:hello).should eq('hello')
        end
    end

    describe "update_index" do
        it "should append method names to the index file" do
            # initialize the interface a bunch and call the
            # registered methods, to make sure they don't keep
            10.times do 
                DummyInterface.new.hello
                DummyInterface.new.goodbye
            end
            target = ['hello', 'dummy']
            include_all = Proc.new do |a,b|
                a.map {|x| b.include?(x) }.uniq == [true]
            end
            indexed = @index.indexed_names
            include_all.call(target,
                             indexed)
                .should eq(true)
            
        end
    end
end
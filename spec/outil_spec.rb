require 'rubygems'
require 'awesome_print'

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Outil do 
    
    before do

        class MyClient
            include Outil

            outil :register
            def foo
                'bar'
            end
        end
        
        Outil::Workspace.sync
    end

    describe "included" do
        it "should include registered methods" do
            client = MyClient.new
            client.hello.should eq('hello')
            client.goodbye.should eq('goodbye')
        end

        it "should allow registration for its own methods" do
            Outil::Workspace.ocs.index.indexed_names.include?('foo').should eq(true)
        end
    end

end
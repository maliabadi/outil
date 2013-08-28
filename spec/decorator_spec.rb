require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'awesome_print'


describe Outil::Decorators::Register do

    describe "adds file and line number to objects" do
    
        before do
            Outil::Workspace.reset!
        end

        it "should send method line numbers and file to the workspace" do
            DummyInterface.new.hello
            Outil::Workspace.references.should eq [[File.dirname(__FILE__) + "/spec_helper.rb", 10, :hello]]
        end
    end

end